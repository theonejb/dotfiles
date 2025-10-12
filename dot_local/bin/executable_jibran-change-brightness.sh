#!/bin/bash

# Check if --down flag is provided
if [[ "$1" == "--down" ]]; then
    ddcutil setvcp 10 - 10
else
    ddcutil setvcp 10 + 10
fi

# Print current brightness value
ddcutil getvcp 10
