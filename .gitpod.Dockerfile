FROM gitpod/workspace-full:latest

# Install desktop + sound + flatpak
USER root
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils \
    pulseaudio pulseaudio-utils alsa-utils \
    flatpak wget curl ca-certificates gnupg lsb-release jq && \
    rm -rf /var/lib/apt/lists/*

# Add Flathub repo
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Optional: pre-install apps (comment out if you want lighter build)
RUN flatpak install -y flathub org.prismlauncher.PrismLauncher && \
    flatpak install -y flathub com.valvesoftware.Steam

USER gitpod
