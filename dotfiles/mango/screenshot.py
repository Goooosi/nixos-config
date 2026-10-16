import fcntl
import os
import subprocess
import tkinter as tk
from datetime import datetime
from PIL import Image, ImageTk, ImageEnhance
 
 
SCREENSHOT_DIR = os.path.expanduser("~/Pictures/Screenshots")
TMP_FILE = "/tmp/freeze_frame.png"
 
HELP_WINDOW = "screenshot-help"

SELECTING_OPACITY = "0.2"
 
os.makedirs(SCREENSHOT_DIR, exist_ok=True)
 

 
LOCK_FILE = os.path.join(
    os.environ.get("XDG_RUNTIME_DIR", "/tmp"),
    "screenshot-tool.lock",
)
 

lock_fd = open(LOCK_FILE, "w")
 
try:
    fcntl.flock(lock_fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
except OSError:
    raise SystemExit(0)
 
 
def run_command(args, **kwargs):
    """Run a command safely and return its result."""
    try:
        return subprocess.run(args, check=False, **kwargs)
    except OSError as exc:
        print(f"Command failed ({args[0]}): {exc}")
        return None
 
 
def set_help_opacity(opacity):
    run_command([
        "eww", "update", f"help_opacity={opacity}"
    ])
 
 
def close_help():
    set_help_opacity("1.0")
    run_command(["eww", "close", HELP_WINDOW])
 
 

 
set_help_opacity("1.0")
run_command(["eww", "open", HELP_WINDOW])
 
# Remove a stale temporary image.
if os.path.exists(TMP_FILE):
    os.remove(TMP_FILE)
 
capture = run_command(["grim", TMP_FILE])
 
if (
    capture is None
    or capture.returncode != 0
    or not os.path.exists(TMP_FILE)
):
    close_help()
    raise SystemExit("Failed to capture the screen with grim.")
 
try:
    orig_img = Image.open(TMP_FILE).convert("RGB")
except Exception as exc:
    close_help()
    raise SystemExit(f"Failed to open screenshot: {exc}")
 
screen_w, screen_h = orig_img.size
 
print(f"Screenshot resolution: {screen_w}x{screen_h}")
 

 
dimmed_img = ImageEnhance.Brightness(orig_img).enhance(0.7)
 
root = tk.Tk()
root.withdraw()
root.overrideredirect(True)
root.geometry(f"{screen_w}x{screen_h}+0+0")
root.attributes("-topmost", True)
 
canvas = tk.Canvas(
    root,
    cursor="cross",
    bg="black",
    highlightthickness=0,
    width=screen_w,
    height=screen_h,
)
canvas.pack(fill="both", expand=True)
 
tk_dimmed = ImageTk.PhotoImage(dimmed_img)
canvas.tk_dimmed = tk_dimmed
 
canvas.create_image(
    0, 0,
    image=tk_dimmed,
    anchor="nw",
    tags="background",
)
 
root.deiconify()
root.focus_force()
canvas.focus_set()
 

 
rect = None
crop_img_ref = None
 
start_x = start_y = 0
cur_x = cur_y = 0
 
cursor_hidden = False
is_transparent = False
selection_started = False
cleaned_up = False
 
 
def clean_exit():
    """Restore the help widget and exit safely."""
    global cleaned_up
 
    if cleaned_up:
        return
 
    cleaned_up = True
    close_help()
 
    try:
        root.destroy()
    except tk.TclError:
        pass
 
    try:
        if os.path.exists(TMP_FILE):
            os.remove(TMP_FILE)
    except OSError:
        pass
 
 
def clamp_x(x):
    return max(0, min(int(x), screen_w))
 
 
def clamp_y(y):
    return max(0, min(int(y), screen_h))
 
 
def on_button_press(event):
    global start_x, start_y, cur_x, cur_y
    global rect, selection_started, is_transparent
 
    start_x = cur_x = clamp_x(event.x)
    start_y = cur_y = clamp_y(event.y)
    selection_started = True
 

    if not is_transparent:
        set_help_opacity(SELECTING_OPACITY)
        is_transparent = True
 
    if rect is not None:
        canvas.delete(rect)
 
    canvas.delete("crop_layer")
 
    rect = canvas.create_rectangle(
        start_x, start_y,
        start_x, start_y,
        outline="#DE635D",
        width=2,
        tags="border",
    )
 
 
def on_move_press(event):
    global cur_x, cur_y, crop_img_ref
 
    if not selection_started or rect is None:
        return
 
    cur_x = clamp_x(event.x)
    cur_y = clamp_y(event.y)
 
    x1 = min(start_x, cur_x)
    y1 = min(start_y, cur_y)
    x2 = max(start_x, cur_x)
    y2 = max(start_y, cur_y)
 
    w = x2 - x1
    h = y2 - y1
 
    canvas.coords(
        rect,
        start_x, start_y,
        cur_x, cur_y,
    )
 

    if w > 0 and h > 0:
        cropped = orig_img.crop((x1, y1, x2, y2))
        crop_img_ref = ImageTk.PhotoImage(cropped)
 
        canvas.delete("crop_layer")
        canvas.create_image(
            x1, y1,
            image=crop_img_ref,
            anchor="nw",
            tags="crop_layer",
        )
 
        canvas.tag_raise("border")
 
 
def selected_region():
    x1 = min(start_x, cur_x)
    y1 = min(start_y, cur_y)
    x2 = max(start_x, cur_x)
    y2 = max(start_y, cur_y)
 
    return x1, y1, x2, y2, x2 - x1, y2 - y1
 
 
def on_space(event):
    """Save the selected region and copy the PNG to the clipboard."""
    if not selection_started:
        clean_exit()
        return
 
    x1, y1, x2, y2, w, h = selected_region()
 
    if w > 0 and h > 0:
        timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        out_path = os.path.join(
            SCREENSHOT_DIR,
            f"{timestamp}.png",
        )
 
        capture = run_command([
            "grim",
            "-g", f"{x1},{y1} {w}x{h}",
            out_path,
        ])
 
        if (
            capture is not None
            and capture.returncode == 0
            and os.path.exists(out_path)
        ):
            try:
                with open(out_path, "rb") as image_file:
                    subprocess.run(
                        ["wl-copy", "--type", "image/png"],
                        stdin=image_file,
                        check=False,
                    )
                print(f"Saved screenshot: {out_path}")
            except OSError as exc:
                print(f"Clipboard copy failed: {exc}")
 
    clean_exit()
 
 
def on_clipboard_only(event):
    """Copy the selected region directly to the Wayland clipboard."""
    if not selection_started:
        clean_exit()
        return
 
    x1, y1, x2, y2, w, h = selected_region()
 
    if w > 0 and h > 0:
        try:
            grim_proc = subprocess.Popen(
                ["grim", "-g", f"{x1},{y1} {w}x{h}", "-"],
                stdout=subprocess.PIPE,
            )
 
            try:
                subprocess.run(
                    ["wl-copy", "--type", "image/png"],
                    stdin=grim_proc.stdout,
                    check=False,
                )
            finally:
                if grim_proc.stdout is not None:
                    grim_proc.stdout.close()
 
            return_code = grim_proc.wait()
 
            if return_code != 0:
                print("grim failed to capture the selected region.")
 
        except OSError as exc:
            print(f"Clipboard capture failed: {exc}")
 
    clean_exit()
 
 
def toggle_cursor(event):
    global cursor_hidden
 
    cursor_hidden = not cursor_hidden
    canvas.config(cursor="none" if cursor_hidden else "cross")
 
 

root.bind("<ButtonPress-1>", on_button_press)
root.bind("<B1-Motion>", on_move_press)
 
root.bind("<space>", on_space)
root.bind("<c>", on_clipboard_only)
root.bind("<C>", on_clipboard_only)
 
root.bind("<p>", toggle_cursor)
root.bind("<P>", toggle_cursor)
 
root.bind("<Escape>", lambda event: clean_exit())
root.protocol("WM_DELETE_WINDOW", clean_exit)

 
try:
    root.mainloop()
finally:
    if not cleaned_up:
        close_help()
 
    try:
        if os.path.exists(TMP_FILE):
            os.remove(TMP_FILE)
    except OSError:
        pass
 

