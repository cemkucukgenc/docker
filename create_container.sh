#!/bin/bash

container_name="sabes_container_noetic"               # Change this to your container name
catkin_ws_path="/sabes_ws/darknet_ros_3d_v1/catkin_ws" # Change this to your catkin_ws path

xhost +
#sudo 
docker run \
    --net=host \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --volume=/home/cemkgenc/sabes_ws:/sabes_ws \
    --volume=/dev:/dev \
    --device-cgroup-rule='c 81:* rmw' \
    --device-cgroup-rule='c 189:* rmw' \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --name $container_name \
    -it \
    -d \
    sabes_image_noetic

sleep 2

# ANSI escape codes for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

#sudo 
docker exec -it $container_name bash -c "
    sudo apt update && sudo apt upgrade -y
    if [ -f '/opt/ros/noetic/setup.bash' ]; then
        source /opt/ros/noetic/setup.bash && \
        if [ \$? -eq 0 ]; then
            echo -e '${GREEN}ROS distro sourced as${RESET}' \$ROS_DISTRO 
        else
            echo -e '${RED}Failed to source ROS distro${RESET}' 
        fi
    else
        echo -e '${YELLOW}/opt/ros/noetic/setup.bash does not exist yet. Skipping sourcing.${RESET}'
    fi && \
    if [ -f '$catkin_ws_path/devel/setup.bash' ]; then
        source $catkin_ws_path/devel/setup.bash && \
        if [ \$? -eq 0 ]; then
            echo -e '${GREEN}ROS workspace sourced as${RESET}' $catkin_ws_path
        else
            echo -e '${RED}Failed to source ROS workspace${RESET}' $catkin_ws_path
        fi
    else
        echo -e '${YELLOW}$catkin_ws_path/devel/setup.bash does not exist yet. Skipping sourcing.${RESET}'
    fi && \
    bash"

exit 0

# To run this script in terminal:
# sudo chmod +x create_container.sh
# ./create_container.sh
