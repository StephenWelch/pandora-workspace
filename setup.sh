#!/bin/bash
set -e

vcs import < src/ros2.repos src
sudo apt-get update
rosdep update
rosdep install --from-paths src --ignore-src -y

# pull submodules
cd /workspaces/pandora-workspace/src/pandora
git submodule update --init --recursive