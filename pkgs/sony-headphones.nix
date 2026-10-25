{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, ninja, git, wayland-scanner
, makeWrapper, bluez, dbus, fontconfig, libGL, copyDesktopItems, makeDesktopItem
, wayland, wayland-protocols, libxkbcommon, libdecor
, libx11, libxext, libxcursor, libxi, libxrandr
, libxfixes, libxscrnsaver, libxtst
, libdrm, libgbm, udev, alsa-lib
}:

let
  fmt-src = fetchFromGitHub {
    owner = "fmtlib";
    repo = "fmt";
    rev = "88a0ae2020a22c6ced639703b72ad4fd8d9ae1d4";
    hash = "sha256-0+FB+OuaU3mo3I+M12vmdtiss8PLQ+jlw4gJOXScNto=";
  };

  imgui-src = fetchFromGitHub {
    owner = "ocornut";
    repo = "imgui";
    rev = "dac07199cfd761113d966eb8ad739254e10df2fe";
    hash = "sha256-wHJliNAMMLpfy2R3weHIPOtaJiZMPxk2S/n7uJPLvzM=";
  };

  sdl3-src = fetchFromGitHub {
    owner = "libsdl-org";
    repo = "SDL";
    rev = "e4ed62ee3f7d7fda8bf8e0f09e42b14a7ac11984";
    hash = "sha256-5H4w1/cJBRjNcg+dnCk7xURYf+31d2YtU7SO8Q7vUWk="; 
  };

  runtimeLibs = [
    wayland libxkbcommon libdecor libGL
    libx11 libxext libxcursor libxi libxrandr
    fontconfig dbus bluez
  ];
in
stdenv.mkDerivation {
  pname = "sony-headphones-client";
  version = "unstable-2026-10-25";

  src = fetchFromGitHub {
    owner = "mos9527";
    repo = "SonyHeadphonesClient";
    rev = "8f4808cb635f5a176df0b7b5aea959818be5129e";
    hash = "sha256-kEhTxLEMCUmA9gfJlZgdN8PETmoAZaRzYeUIupaXiI8=";
  };

  nativeBuildInputs = [ cmake pkg-config ninja git wayland-scanner makeWrapper copyDesktopItems ];

  buildInputs = [
    bluez dbus fontconfig libGL
    wayland wayland-protocols libxkbcommon libdecor
    libx11 libxext libxcursor libxi libxrandr
    libxfixes libxscrnsaver libxtst
    libdrm libgbm udev alsa-lib
  ];

  cmakeFlags = [
    "-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
    "-DFETCHCONTENT_SOURCE_DIR_FMT=${fmt-src}"
    "-DFETCHCONTENT_SOURCE_DIR_IMGUI=${imgui-src}"
    "-DFETCHCONTENT_SOURCE_DIR_SDL3=${sdl3-src}"
    "-DMDR_BUILD_CODEGEN=OFF"
    "-DMDR_BUILD_TESTING=OFF"
  ];
  postPatch = ''
    sed -i '0,/#include/s//#include <cstring>\n#include/' libmdr/include/mdr/Protocol.hpp
  '';

  ninjaFlags = [ "SonyHeadphonesClient" ];

  installPhase = ''
    runHook preInstall
    install -Dm755 client/SonyHeadphonesClient $out/bin/SonyHeadphonesClient
    wrapProgram $out/bin/SonyHeadphonesClient \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibs}
    runHook postInstall
  '';
  desktopItems = [
    (makeDesktopItem {
      name = "sony-headphones-client";
      desktopName = "Sony Headphones Client";
      comment = "Control Sony headphones from your desktop";
      exec = "SonyHeadphonesClient";
      icon = "audio-headphones";
      categories = [ "Audio" "AudioVideo" "Settings" ];
      terminal = false;
    })
  ];
  meta = {
    description = "Third-party client for Sony Sound Connect headphones";
    homepage = "https://github.com/mos9527/SonyHeadphonesClient";
    license = lib.licenses.mit;
    mainProgram = "SonyHeadphonesClient";
    platforms = lib.platforms.linux;
  };
}
