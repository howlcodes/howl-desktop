#!/usr/bin/env bash
set -e

# Start PulseAudio for sound
pulseaudio --start --exit-idle-time=-1 || true
pactl load-module module-native-protocol-tcp auth-anonymous=1 || true

# Install TigerVNC + XFCE if missing
sudo apt-get update
sudo apt-get install -y tigervnc-standalone-server tigervnc-common xfce4 xfce4-goodies

# Create VNC startup config if not present
mkdir -p ~/.vnc
cat >~/.vnc/xstartup <<'EOF'
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# Kill any existing VNC servers
vncserver -kill :1 || true

# Start VNC server on display :1 (will map to port 5901, web client uses 6901)
vncserver :1 -geometry 1280x800 -SecurityTypes None

echo "✅ TigerVNC started on port 5901 (Gitpod forwards to 6901)."
