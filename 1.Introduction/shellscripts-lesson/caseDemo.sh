#!/bin/bash
option="$1"
if [ -z "$option" ]; then 
    echo " ⚠️  Usage: $0 up|down " 
    exit 1 
fi 
 
case "$option" in
    "up") 
        echo "Starting the service ✅" 
        ;; 
    "down")
        echo "Shutting down the service 🟥" 
        ;; 
    *)
        echo " ❌ Invalid operations! Try again with up or down" 
    ;; 
esac
