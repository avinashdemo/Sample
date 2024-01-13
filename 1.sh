#!/bin/bash

containers=("app1" "app2" "app3")  # Add your container names here

trap 'kill $(jobs -p)' EXIT  # Ensure all background processes are killed when the script exits

start_log_stream() {
    container="$1"
    docker logs --tail=0 -f "$container" | grep --line-buffered --color=never . >> "${container}_logs.txt" &
}

# Initial log stream setup
for container in "${containers[@]}"; do
    start_log_stream "$container"
done

# Monitor Docker events for container changes
docker events --filter 'event=start' --filter 'event=stop' --format '{{.Actor.Attributes.name}}' | while read -r container; do
    if [[ " ${containers[*]} " == *" $container "* ]]; then
        start_log_stream "$container"
    fi
done

wait
