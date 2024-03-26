# Taking the ROS noetic image as base
FROM osrf/ros:noetic-desktop-full

# To have not questions during the installation
ENV DEBIAN_FRONTEND=noninteractive

# Install the basic packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git apt-utils python3-catkin-tools wget libtool gedit && \
    rm -rf /var/lib/apt/lists/*

# Install the necessary ROS packages for the project
RUN apt-get update && apt-get upgrade -y && \
    apt-get install ros-noetic-cv-bridge ros-noetic-image-transport ros-noetic-tf ros-noetic-ddynamic-reconfigure ros-noetic-diagnostic-updater -y && \
    apt-get install ros-noetic-realsense2-camera ros-noetic-realsense2-description -y && \
    rm -rf /var/lib/apt/lists/*

# For Intel GPU support
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-video-intel intel-opencl-icd intel-media-va-driver-non-free && \
    rm -rf /var/lib/apt/lists/* 

# Reset the environment variable
ENV DEBIAN_FRONTEND=

# For easy sourcing of ROS workspace
COPY rosource.sh /usr/local/bin/rosource
RUN chmod +x /usr/local/bin/rosource

# To build the docker image, run the following command:
# sudo docker image build -t sabes_image_noetic .

# To delete the old docker image, run the following command:
# sudo docker images
# sudo docker image rm <image_name>
