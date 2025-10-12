#!/bin/bash
if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q "yes"; then
    echo "MIC MUTED"
else
    echo "MIC ON"
fi
