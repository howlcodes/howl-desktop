#!/usr/bin/env bash
set -e

# Start PulseAudio
pulseaudio --start --exit-idle-time=-1 || true
pactl load-module module-native-protocol-tcp auth-anonymous=1 || true

# Start XFCE desktop inside KasmVNC
if ! command -v vncserver >/dev/null; then
  echo "Downloading KasmVNC..."
  RELEASE_JSON=$(curl -s https://api.github.com/repos/kasmtech/KasmVNC/releases/latest)
  KASM_DEB=$(echo "$RELEASE_JSON" | jq -r '.assets[]?.browser_download_url | select(endswith(".deb") and (contains("amd64"))) ' | head -n1)
  wget -q -O /tmp/kasmvnc.deb "$KASM_DEB"
  sudo dpkg -i /tmp/kasmvnc.deb || (sudo apt-get -f install -y && sudo dpkg -i /tmp/kasmvnc.deb)
fi

# Minimal xinitrc
cat >~/.xinitrc <<'XINIT'
exec startxfce4
XINIT

# Start VNC
vncserver -geometry 1280x800 -SecurityTypes None
