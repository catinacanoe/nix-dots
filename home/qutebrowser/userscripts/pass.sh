#!/usr/bin/env bash

echo "hint inputs -f" >> "$QUTE_FIFO" # opens the first field
pw "$@"
