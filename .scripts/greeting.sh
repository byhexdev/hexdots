#!/bin/bash
phrases=(
    "you look dogshit today, $USER."
    "howdy, $USER."
)

echo "${phrases[$RANDOM % ${#phrases[@]}]}"
