*This project has been created as part of the 42 curriculum by xingchen.*

# Description

The **Born2beRoot** project aims to introduce the basics of system administration.
It consists of installing and configuring a server (Debian or Rocky) following strict security rules, without a graphical interface, in order to understand the basic functioning of a server system.

This project allows you to complete several key steps in configuring a virtual server:
- Virtual machine installation and partitioning with encrypted LVM
- Basic service configuration (SSH, firewall)
- User and permission management with sudo
- Implementation of a secure password policy
- Automated script execution via cron
- Setting up a monitoring system to track server status

---

## Project Description
I chose **Debian (stable version)** for this project.

### Why Debian?
**Advantages:**
- Very stable and reliable
- Abundant documentation
- Simple to administer for beginners
- Large community

**Disadvantages:**
- Software sometimes less recent than other distributions

### Technical Comparisons

#### Debian vs Rocky Linux
- **Debian**: simpler, more stable, ideal for beginners
- **Rocky**: more complex, enterprise-oriented, RHEL clone

#### AppArmor vs SELinux
- **AppArmor**: easier to configure, based on file paths
- **SELinux**: more powerful but more complex, based on security labels

#### UFW vs firewalld
- **UFW**: simple, clear, suitable for Debian
- **firewalld**: more flexible, used on Rocky and Red Hat systems

#### VirtualBox vs UTM
- **VirtualBox**: widely used, easy to use, cross-platform
- **UTM**: alternative on Mac M1/M2 (ARM architecture)

---

# Instructions

## Prerequisites
- VirtualBox (or UTM if VirtualBox unavailable)
- Debian stable ISO
- No graphical environment (X.org, Wayland prohibited)

## Installation and Configuration

### 1. Base System
- Install Debian in server mode
- Partitioning: LVM + encryption
- System update
```bash
sudo apt update
```

### 2. Users and Groups
- Create user with your login
- Add to `user42` and `sudo` groups
```bash
sudo adduser 
sudo addgroup user42
#sudo adduser <username> user42
#sudo adduser <username> sudo
```

### 3. Password Policy
**Expiration:** 30 days | **Modification delay:** 2 days | **Alert:** 7 days before expiration

**Complexity:** 10 characters min, 1 uppercase, 1 lowercase, 1 digit, max 3 identical consecutive characters, no username

### 4. SSH Configuration
```bash
# Port 4242, root login disabled
Port 4242
PermitRootLogin no
```

### 5. UFW Firewall
```bash
sudo ufw allow 4242
sudo ufw enable
# Only port 4242 open
```

### 6. Sudo Configuration
- 3 attempts max
- Full logging
- TTY mode required
- Restricted execution paths

### 7. monitoring.sh Script
**Display every 10 min (via cron):**
- System architecture + kernel version
- Physical/virtual CPUs
- RAM (used/total + %)
- Disk (used/total + %)
- CPU load (%)
- Last reboot
- LVM status
- Active TCP connections
- Connected users
- IPv4 + MAC
- Sudo commands executed
```bash
# Configure cron
sudo crontab -e
# Add: */10 * * * * /path/to/monitoring.sh
```

---

## Validation Checklist
- [ ] Encrypted LVM partitioning
- [ ] Password policy applied
- [ ] SSH on port 4242, root disabled
- [ ] UFW active, only port 4242 open
- [ ] sudo configured with restrictions
- [ ] monitoring.sh executed every 10 min

---

# Resources

### Classic Documentation
- [Official Debian Documentation](https://www.debian.org/doc/)
- Manual pages: `man sudo`, `man ssh`, `man ufw`, `man cron`
- [LVM Documentation](https://tldp.org/HOWTO/LVM-HOWTO/)
- Official 42 documentation

### Use of AI
AI was used for:
- Clarifying certain theoretical concepts (LVM, SSH, sudo, security policies)
- Rephrasing technical explanations to improve clarity
- Improving the structure and presentation of the README

**No part of the code or project configuration was automated by AI.** All installation and configuration


