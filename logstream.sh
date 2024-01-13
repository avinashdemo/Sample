#!/bin/bash

containers=("app1" "app2" "app3")  # Add your container names here

trap 'kill $(jobs -p)' EXIT  # Ensure all background processes are killed when the script exits

while true; do
    for container in "${containers[@]}"; do
        if docker inspect --format '{{.State.Running}}' "$container" 2>/dev/null; then
            docker logs --tail=0 -f "$container" | grep --line-buffered --color=never . >> "${container}_logs.txt" &
        fi
    done

    sleep 5  # Adjust the interval based on your needs
done
