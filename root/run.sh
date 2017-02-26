#!/bin/bash

echo "*-------------------------------------------*"
echo "|       Running startup configuration       |"
echo "*-------------------------------------------*"

for script in /setup.d/*; do
    bash "$script"
done

echo "*-------------------------------------------*"
echo "|             Starting Services             |"
echo "*-------------------------------------------*"

/init
