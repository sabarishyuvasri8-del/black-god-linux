# ⚡ Black God Linux

<p align="center">
  <strong>A custom penetration testing & ethical hacking Linux distribution</strong><br/>
  <em>Built on Kali Rolling | Powered by Debian</em>
</p>

---

## 🔥 What is Black God Linux?

**Black God Linux** is a purpose-built cybersecurity operating system featuring:

- **300+ Pre-installed Security Tools** — All tools from Kali Linux: Nmap, Metasploit, Wireshark, Burp Suite, Aircrack-ng, Hydra, John the Ripper, SQLmap, Ghidra, and more.
- **Custom Dark Cyber UI** — XFCE desktop with a black & gold hacker aesthetic.
- **Black God Automation Scripts**:
  - `blackgod-recon` — Automated reconnaissance (DNS, WHOIS, Nmap, WhatWeb, Gobuster).
  - `blackgod-update` — One-command full system & tool database update.
  - `blackgod-wifi` — One-click Wi-Fi monitor mode toggle.
- **Custom ZSH Terminal** — Themed prompt with tool aliases and ASCII welcome banner.

---

## 🛠️ Tool Categories

| Category | Tools |
| :--- | :--- |
| **Information Gathering** | Nmap, Masscan, Amass, theHarvester, Recon-ng, Maltego, DNSRecon |
| **Vulnerability Analysis** | Nikto, OpenVAS, Legion |
| **Web Application Testing** | Burp Suite, ZAP Proxy, SQLmap, WPScan, Gobuster, ffuf |
| **Password Attacks** | John the Ripper, Hashcat, Hydra, Medusa, CeWL, SecLists |
| **Wireless Attacks** | Aircrack-ng, Wifite, Kismet, Reaver, Bettercap |
| **Exploitation** | Metasploit Framework, Armitage, BeEF, SET, RouterSploit |
| **Sniffing & Spoofing** | Wireshark, Ettercap, Bettercap, Responder, MITMProxy |
| **Reverse Engineering** | Ghidra, Radare2, GDB, Rizin-Cutter, APKTool |
| **Post Exploitation** | Evil-WinRM, CrackMapExec, Impacket, BloodHound |
| **Forensics** | Autopsy, Binwalk, Volatility, Foremost, Steghide |
| **Anonymity** | Tor, ProxyChains, AnonSurf |

---

## 🚀 Build from Source

### Option 1: GitHub Actions (Recommended)
1. Fork this repository.
2. Go to **Actions** tab → **Build Black God Linux ISO** → **Run workflow**.
3. Wait ~45 minutes for the cloud build to complete.
4. Download the ISO from the **Artifacts** section.

### Option 2: Build Locally (Requires Debian/Ubuntu)
```bash
sudo apt install -y live-build debootstrap git
git clone https://github.com/YOUR_USERNAME/black-god-linux.git
cd black-god-linux
sudo ./build.sh
```

---

## 💿 Installation

### Boot in a Virtual Machine
```bash
# Using QEMU
qemu-system-x86_64 -m 4096 -enable-kvm -cdrom black-god-linux-*.iso

# Or import the ISO into VirtualBox / UTM / VMware
```

### Flash to USB Drive
```bash
sudo dd if=black-god-linux-*.iso of=/dev/sdX bs=4M status=progress
```
> Replace `/dev/sdX` with your USB device. Use `lsblk` to identify.

---

## ⚠️ Legal Disclaimer

**Black God Linux is intended for authorized security testing and educational purposes ONLY.**

Unauthorized access to computer systems is illegal. Always obtain proper written authorization before performing any penetration testing. The developers of Black God Linux are not responsible for any misuse of this software.

---

## 📜 License

This project is licensed under the **GNU General Public License v3.0**.

Built with ⚡ by Sabarish.
