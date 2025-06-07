#!/bin/bash

# Vikey Inference installer script
# Author: direkturcrypto
# Usage: sudo bash install.sh

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

# Create installation directory
INSTALL_DIR="/usr/local/lib/vikey-inference"
mkdir -p $INSTALL_DIR

# Copy binary and configuration files
if [ -f "vikey-inference-linux" ]; then
  cp vikey-inference-linux /usr/local/bin/
  chmod +x /usr/local/bin/vikey-inference-linux
else
  echo "Error: Binary file vikey-inference-linux not found!"
  exit 1
fi

# Copy configuration files
if [ -f "models.json" ]; then
  cp models.json $INSTALL_DIR/
else
  echo "Warning: models.json not found, creating a default one."
  echo '[]' > $INSTALL_DIR/models.json
fi

if [ -f ".env" ]; then
  cp .env $INSTALL_DIR/
elif [ -f ".env.example" ]; then
  cp .env.example $INSTALL_DIR/.env
  echo "Warning: Using .env.example as .env. Make sure to update with your API key."
else
  echo "Warning: .env not found, creating a minimal one."
  echo "NODE_PORT=11434" > $INSTALL_DIR/.env
  echo "VIKEY_API_KEY=your_default_api_key_here" >> $INSTALL_DIR/.env
  echo "LLAMAEDGE_ENABLED=false" >> $INSTALL_DIR/.env
  echo "GAIA_CONFIG_PATH=./config" >> $INSTALL_DIR/.env
fi

# Create symlink to working directory
ln -sf $INSTALL_DIR/.env /usr/local/bin/.env
ln -sf $INSTALL_DIR/models.json /usr/local/bin/models.json

# Install systemd service if available
if [ -f "vikey-inference.service" ]; then
  cp vikey-inference.service /etc/systemd/system/
  systemctl daemon-reload
  systemctl enable vikey-inference.service
  echo "Systemd service installed. Start with: sudo systemctl start vikey-inference"
else
  echo "No systemd service file found. You can run the application manually."
fi

echo ""
echo "Installation completed!"
echo "Binary installed to: /usr/local/bin/vikey-inference-linux"
echo "Configuration files installed to: $INSTALL_DIR"
echo ""
echo "Run manually with: vikey-inference-linux"
echo "Or if systemd service was installed: sudo systemctl start vikey-inference"
echo "" 