#!/bin/bash

SEARCH_DIR="$1"

find "$SEARCH_DIR" -type d -name '.git' | while read -r dir; do
	repo_path=$(dirname "$dir")
	origin_url=$(git -C "$repo_path" remote get-url origin 2>/dev/null)
	if [ $? -eq 0 ]; then
		echo "$origin_url"
	fi
done
