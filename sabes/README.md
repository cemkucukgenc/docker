# Docker container setup

If you have a different Linux or ROS distro than specified requirements, you may prefer to use a Docker container. To do that, an example Docker container implementation for a PC with `Intel i7-1165G7` CPU (no Discreet GPU) and `Ubuntu 22.04` is explained. In any case, you should try to implement it according to your system with external sources. This method is not guaranteed to work perfectly in your system.

Useful video tutorial links for your reference

- https://www.youtube.com/watch?v=qWuudNxFGOQ
- https://www.youtube.com/watch?v=oULAVsGlLe8&t

## Installation guide

Install the Docker by the following link

- https://docs.docker.com/desktop/install/ubuntu/

Open a terminal (will be mentioned as T1) and create a directory preferably in the `home` location as
```
mkdir -p sabes_ws
cd sabes_ws
```
Clone the project repository (T1)
```
git clone git@gitlab.lrz.de:innok-roboter/human_and_object_detection/docker.git
```
On `docker/create_container.sh`, change line 4 to your `catkin_ws_path` and line 11 to your shared volume path.

On `docker/continue_container.sh`, change the line 4 as your `catkin_ws_path`.

Bonus: The `rosource.sh` is created to source the `catkin_ws_path` easily. If you want to use that too; on `docker/rosource.sh`, change line 3 to your `catkin_ws_path`.

Pull the corresponding Docker image, in this case for `ROS Noetic` (T1)
```
sudo docker pull osrf/ros:noetic-desktop-full
```
Create the necessary Docker image `sabes_image` (T1)
```
cd docker
sudo docker image build -t sabes_image .
```
Make the shell scripts executable (T1)
```
sudo chmod +x create_container.sh
sudo chmod +x continue_container.sh
```
Create the Docker container `sabes_container` (T1)
```
./create_container.sh
```
Congrats! Your container is created and the shared volume is already including the local project directory. Use this container to run the project.

## Container management 

Here are some useful commands that will be needed in the further steps of running the project on the Docker container. Docker container will no longer be explained, you should be able to set up, reach, or delete the containers by yourself with this information.

To reach the container on another terminal
```
cd sabes_ws/docker
./continue_container.sh
```
or
```
sudo docker exec -it sabes_container bash
```

To list and delete the image
```
sudo docker images
sudo docker image rm sabes_image
```

To list and delete the container
```
sudo docker ps -a
sudo docker stop sabes_container
sudo docker rm sabes_container
```
