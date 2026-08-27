{ pkgs, ... }:
{
flake.modules.nixos.users = { ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root.hashedPassword = "!";
  users.users."admin" = {
    isNormalUser = true;
    description = "New Admin";
    extraGroups = [ "networkmanager" "wheel" ];  # wheel = sudo/admin access
    packages = with pkgs; [ ];
  };
  users.users."zi" = {
    isNormalUser = true;
    description = "zi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
};
}
