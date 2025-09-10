FROM gitpod/workspace-full:latest

# Prevent interactive prompts
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install desktop + sound + flatpak
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils \
        pulseaudio pulseaudio-utils alsa-utils \
        flatpak wget curl ca-certificates gnupg lsb-release jq && \
    rm -rf /var/lib/apt/lists/*

# Add Flathub repo
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# (Optional) Preinstall apps – comment these out if build is failing
# RUN flatpak install -y flathub org.prismlauncher.PrismLauncher
# RUN flatpak install -y flathub com.valvesoftware.Steam

USER gitpod
