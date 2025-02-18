#!/bin/bash

# Color definitions (optional, for supported terminals)
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to check if a command exists
function check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}$1 is not installed. Please install it to use this option.${NC}"
        return 1
    else
        return 0
    fi
}

# Function to prompt for user input and clear the screen afterward
function press_enter() {
    echo ""
    echo -ne "${CYAN}Press Enter to continue...${NC}"
    read
    clear
}

# Function to print the header with categories
function print_header() {
    echo -e "${GREEN}==============================================${NC}"
    echo -e "${GREEN}          SYSTEM MONITORING MENU              ${NC}"
    echo -e "${GREEN}==============================================${NC}"
    echo ""
}

# Main loop for the menu
while true; do
    clear
    print_header

    echo -e "${CYAN}SYSTEM INFORMATION:${NC}"
    echo "-------------------"
    echo "  1) Disk Usage            - df -h (human-readable disk space)"
    echo "  2) Memory Info (MB)      - free -m (memory in megabytes)"
    echo "  3) System Uptime         - uptime (system load and uptime)"
    echo "  4) Last Reboot Time      - last reboot (system reboot history)"
    echo ""
    echo -e "${CYAN}PERFORMANCE STATISTICS:${NC}"
    echo "-----------------------"
    echo "  5) Virtual Memory Stats  - vmstat (process, memory & swap stats)"
    echo "  6) CPU Utilization       - mpstat -P ALL (per-CPU statistics)"
    echo "  7) I/O Statistics        - iostat (detailed I/O stats)"
    echo "  8) Process List          - ps aux (snapshot of current processes)"
    echo "  9) Interactive Process   - htop (dynamic real-time view)"
    echo ""
    echo -e "${CYAN}NETWORK INFORMATION:${NC}"
    echo "--------------------"
    echo " 10) IP Address Info       - ip a (or ipconfig on Windows)"
    echo " 11) Network Statistics    - netstat -tulpen (detailed network info)"
    echo ""
    echo "  0) Exit"
    echo ""
    echo -ne "Enter your selection: "
    read selection
    echo ""
    case $selection in
        1)
            df -h
            press_enter
            ;;
        2)
            free -m
            press_enter
            ;;
        3)
            uptime
            press_enter
            ;;
        4)
            last reboot
            press_enter
            ;;
        5)
            vmstat
            press_enter
            ;;
        6)
            check_command mpstat || { press_enter; continue; }
            mpstat -P ALL
            press_enter
            ;;
        7)
            check_command iostat || { press_enter; continue; }
            iostat
            press_enter
            ;;
        8)
            ps aux
            press_enter
            ;;
        9)
            check_command htop || { press_enter; continue; }
            htop
            press_enter
            ;;
        10)
            # Prefer 'ip a' for Linux, fallback to 'ipconfig' (for Windows environments)
            if command -v ip &> /dev/null; then
                ip a
            elif command -v ipconfig &> /dev/null; then
                ipconfig
            else
                echo -e "${RED}Neither 'ip' nor 'ipconfig' command found.${NC}"
            fi
            press_enter
            ;;
        11)
            check_command netstat || { press_enter; continue; }
            netstat -tulpen
            press_enter
            ;;
        0)
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid selection. Please try again.${NC}"
            press_enter
            ;;
    esac
done
