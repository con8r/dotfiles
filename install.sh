#!/usr/bin/env bash
# Installs all dependencies referenced across this dotfiles repo.
# Run from anywhere: ./install.sh
set -e

# --- Official repo packages (pacman) ---
PACMAN_PKGS=(
    niri
    alacritty
    ttf-jetbrains-mono-nerd
    swaylock
    orca
    pipewire
    wireplumber
    playerctl
    brightnessctl
    flatpak
    discord
    nautilus
    fastfetch
)

# --- AUR packages (needs paru or yay) ---
AUR_PKGS=(
    noctalia-shell-git
    linux-wallpaperengine
    zen-browser-bin
    hyfetch
)

echo "==> Installing official repo packages..."
sudo pacman -S --needed "${PACMAN_PKGS[@]}"

# Detect an AUR helper
AUR_HELPER=""
if command -v paru &>/dev/null; then
    AUR_HELPER="paru"
elif command -v yay &>/dev/null; then
    AUR_HELPER="yay"
fi

if [ -n "$AUR_HELPER" ]; then
    echo "==> Installing AUR packages with $AUR_HELPER..."
    "$AUR_HELPER" -S --needed "${AUR_PKGS[@]}"
else
    echo "==> No AUR helper (paru/yay) found."
    echo "    Install one first, or install these manually from the AUR:"
    printf '    - %s\n' "${AUR_PKGS[@]}"
fi

echo "==> Adding Spotify Flatpak (used via 'flatpak run com.spotify.Client')..."
flatpak install -y flathub com.spotify.Client || echo "    Skipped (Flathub remote may need adding first: flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo)"

echo ""
echo "==> Done. Notes:"
echo "    - noctalia-shell-git and zen-browser-bin package names may drift on the AUR;"
echo "      if either fails, search 'noctalia' / 'zen browser' on your AUR helper and adjust."
echo "    - polkit-gnome is spawned in niri/config.kdl but was removed from most repos;"
echo "      check if it's already pulled in as a dependency, or swap to polkit-kde-agent."
echo "    - waybar is NOT installed here since it's likely a leftover in the config"
echo "      (Noctalia already provides the bar) — add it back manually if you actually use it."
