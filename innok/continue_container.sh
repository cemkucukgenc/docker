#!/bin/bash

container_name="innok_container" # Change this to your container name
catkin_ws_path="/innok_ws/catkin_ws" # Change this to your catkin_ws path

# ANSI escape codes for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

sudo docker exec -it $container_name bash -c \
  "source /opt/ros/noetic/setup.bash && \
   if [ \$? -eq 0 ]; then
     echo -e '${GREEN}ROS distro sourced as${RESET}' \$ROS_DISTRO 
   else
     echo -e '${RED}Failed to source ROS distro${RESET}' 
   fi && \
   source $catkin_ws_path/devel/setup.bash && \
   if [ \$? -eq 0 ]; then
     echo -e '${GREEN}ROS workspace sourced as${RESET}' $catkin_ws_path
   else
     echo -e '${RED}Failed to source ROS workspace${RESET}'
   fi && \
   bash"

exit 0

# To run this script in terminal:
# sudo chmod +x continue_container.sh
# ./continue_container.sh
