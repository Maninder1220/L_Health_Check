#!/bin/bash

function press_enter
{
    echo ""
    echo -n "Press Enter to continue"
    read
    clear
}

selection=
until [ "$selection" = "0" ]; do
    echo ""
    echo "PROGRAM MENU"
    echo "1 - display free disk space"
    echo "2 - display free memory"
    echo "3 - displays information about the users currently on the machine"
    echo "4 - Display Comparison of CPU utilization"
    echo "5 - Display last Reboot Server"
    echo "6 - Virtual Memory Statistics"
    echo "7 - View the users who have logged in recently system"
    echo "8 - check system uptime"

    echo ""
    echo "0 - exit program"
    echo ""
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in
        1 ) df -h ; press_enter ;;
        2 ) free ; press_enter ;;
        3 ) w ; press_enter;;
        4 ) mpstat -P ALL ; press_enter;;
        5 ) last reboot ; press_enter;;
        6 ) vmstat; press_enter;;
        7 ) last -a | head -10 ; press_enter;;
        8 ) uptime ; press_enter;;
        0 ) exit ;;
        * ) echo "Please enter 1, 2, 3, 4. 5, 6, 7, 8 or 0"; press_enter
    esac
done
