#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'  # Green color
NC='\033[0m'        # No color

# Function to display a separator line
separator() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '#'
    echo
}

# Function to display a header without separator
header() {
    echo -e "${GREEN}### $1 ###${NC}"
    echo "# $2"  # Subnote or description
    echo
}

# Function to strip ANSI escape sequences (colors)
strip_colors() {
    sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

# Function to check if the user has sudo rights
check_sudo() {
    sudo -l >/dev/null 2>&1
    return $?
}

# Execute commands and display output with headers

header "env" "Checking env variable"
env | strip_colors

separator

header "sudo --version" "1.8.31 Ubuntu 20.04 - 1.8.27 Debian 10 - 1.9.2 Fedora 33 vulnerable"
if check_sudo; then
    sudo --version
else
    echo "User does not have sudo rights for this command"
fi

separator

header "sudo -l"
if check_sudo; then
    sudo -l
else
    echo "User does not have sudo rights for this command"
fi

separator

header "screen --version" "Screen 4.5.0 is vulnerable https://www.exploit-db.com/exploits/41154"
screen --version

separator

header "ls -la /etc/shadow" "Hashes can be found in shadow to crack by unshadowing and john"
ls -la /etc/shadow

separator

header "ls -la /etc/passwd" "Check if you can write to passwd file to create a user that overwrites shadow"
ls -la /etc/passwd

separator

header "cat /etc/issue" 
cat /etc/issue

separator

header "cat /etc/os-release"
cat /etc/os-release

separator

header "uname -a" "check for kernel vulnerabilities like Dirty Cow"
uname -a

separator

header "ls -lah /etc/cron*"
ls -lah /etc/cron*

separator

header "grep 'CRON' /var/log/syslog"
grep "CRON" /var/log/syslog


separator

header "find / -perm -u=s -type f 2>/dev/null" "GTFOBins"
find / -perm -u=s -type f 2>/dev/null

separator

header "/usr/sbin/getcap -r / 2>/dev/null" "GTFOBins"
/usr/sbin/getcap -r / 2>/dev/null

separator
