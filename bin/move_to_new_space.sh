#!/bin/bash

yabai -m space --create && \
index=$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index') && \
cur_window=$(yabai -m query --windows --window | jq '.id') && \
yabai -m window --space ${index} && \
yabai -m window --focus ${cur_window}
