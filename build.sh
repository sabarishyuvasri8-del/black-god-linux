#!/bin/bash
# ═══════════════════════════════════════════════════════
#  BLACK GOD LINUX — Master Build Script
#  Compiles the complete ISO from Kali live-build config
# ═══════════════════════════════════════════════════════

set -e

RED='\033[1;31m'
GOLD='\033[1;33m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
DIM='\033[2m'
RESET='\033[0m'

echo ""
echo -e "${RED}    ██████╗ ██╗      █████╗  ██████╗██╗  ██╗     ██████╗  ██████╗ ██████╗ ${RESET}"
echo -e "${RED}    ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝    ██╔════╝ ██╔═══██╗██╔══██╗${RESET}"
echo -e "${GOLD}    ██████╔╝██║     ███████║██║     █████╔╝     ██║  ███╗██║   ██║██║  ██║${RESET}"
echo -e "${GOLD}    ██╔══██╗██║     ██╔══██║██║     ██╔═██╗     ██║   ██║██║   ██║██║  ██║${RESET}"
echo -e "${RED}    ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗    ╚██████╔╝╚██████╔╝██████╔╝${RESET}"
echo -e "${RED}    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝     ╚═════╝  ╚═════╝ ╚═════╝ ${RESET}"
echo -e "${WHITE}                    ⚡ ISO BUILD ENGINE ⚡${RESET}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[✗]${RESET} Must be run as root: sudo ./build.sh"
    exit 1
fi

# Check dependencies
echo -e "${GREEN}[1/6]${RESET} ${WHITE}Checking build dependencies...${RESET}"
DEPS="live-build debootstrap git curl"
for dep in $DEPS; do
    if ! command -v $dep &> /dev/null; then
        echo -e "${GOLD}  → Installing $dep...${RESET}"
        apt-get install -y $dep > /dev/null 2>&1
    fi
done
echo -e "${DIM}  ✓ All dependencies satisfied.${RESET}"

# Add Kali GPG key if missing
echo -e "\n${GREEN}[2/6]${RESET} ${WHITE}Configuring Kali repository keys...${RESET}"
if [ ! -f /usr/share/keyrings/kali-archive-keyring.gpg ]; then
    echo -e "${GOLD}  → Fetching Kali archive keyring...${RESET}"
    wget -q https://archive.kali.org/archive-key.asc -O- | gpg --dearmor > /usr/share/keyrings/kali-archive-keyring.gpg
fi
echo -e "${DIM}  ✓ Kali GPG keys configured.${RESET}"

# Clean previous builds
echo -e "\n${GREEN}[3/6]${RESET} ${WHITE}Cleaning previous build artifacts...${RESET}"
lb clean --purge 2>/dev/null || true
echo -e "${DIM}  ✓ Clean slate.${RESET}"

# Configure live-build
echo -e "\n${GREEN}[4/6]${RESET} ${WHITE}Initializing live-build configuration...${RESET}"
lb config
echo -e "${DIM}  ✓ Configuration loaded.${RESET}"

# Make custom scripts executable
echo -e "\n${GREEN}[5/6]${RESET} ${WHITE}Setting permissions on Black God scripts...${RESET}"
chmod +x kali-config/common/includes.chroot/usr/local/bin/blackgod-* 2>/dev/null || true
chmod +x kali-config/common/includes.chroot/etc/update-motd.d/* 2>/dev/null || true
echo -e "${DIM}  ✓ Scripts marked executable.${RESET}"

# Build the ISO
echo -e "\n${GREEN}[6/6]${RESET} ${WHITE}Building Black God Linux ISO...${RESET}"
echo -e "${DIM}  This will download ~3-4 GB of packages and may take 30-60 minutes.${RESET}"
echo -e "${DIM}  Build log is saved to build.log${RESET}"
echo ""

lb build 2>&1 | tee build.log

# Rename the output ISO
ISO_FILE=$(ls *.iso 2>/dev/null | head -1)
if [ -n "$ISO_FILE" ]; then
    FINAL_NAME="black-god-linux-$(date +%Y%m%d)-amd64.iso"
    mv "$ISO_FILE" "$FINAL_NAME"
    ISO_SIZE=$(du -h "$FINAL_NAME" | awk '{print $1}')
    
    echo ""
    echo -e "${DIM}════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}[✓]${RESET} ${WHITE}BUILD COMPLETE!${RESET}"
    echo -e "${GOLD}[*]${RESET} ISO File: ${GOLD}${FINAL_NAME}${RESET}"
    echo -e "${GOLD}[*]${RESET} Size:     ${GOLD}${ISO_SIZE}${RESET}"
    echo -e "${DIM}════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "${WHITE}Next steps:${RESET}"
    echo -e "  1. Boot in VM:   ${DIM}qemu-system-x86_64 -m 4096 -enable-kvm -cdrom ${FINAL_NAME}${RESET}"
    echo -e "  2. Flash to USB: ${DIM}sudo dd if=${FINAL_NAME} of=/dev/sdX bs=4M status=progress${RESET}"
    echo ""
else
    echo -e "${RED}[✗]${RESET} Build failed. Check build.log for details."
    exit 1
fi
