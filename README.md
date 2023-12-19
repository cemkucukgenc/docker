# Docker containers

## To delete the container
```
sudo docker ps -a
sudo docker stop <container_name>
sudo docker rm <container_name>
sudo docker rm -f $(sudo docker ps -a -q)
```
## To delete the old docker image
```
sudo docker images
sudo docker rmi <image_name>
sudo docker image rm <image_name>
```
## To build the docker image
```
sudo docker image build -t <image_name> .
```
## This can be useful to reach the GUI running on container, but also dangerous
```
xhost +local:root
```
## Useful tutorials

- https://www.youtube.com/watch?v=qWuudNxFGOQ
- https://www.youtube.com/watch?v=oULAVsGlLe8&t