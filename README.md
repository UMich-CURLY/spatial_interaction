# vulcan_docker
Install docker-ce and then install the NVIDIA Container Toolkit using this link:
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

Finally, run these commands to clone this repo and build an image:

```bash
cd ~
git clone https://github.com/UMich-CURLY/vulcan_docker.git
sudo docker build vulcan_docker/ --tag dockerv1
```

Run the bash file as follows:

```bash
cd vulcan_docker/
sudo chmod +x vulcan_image.sh
sudo ./vulcan_image.sh
```
  
Now run 
  1. catkin_make - to built packages
  2. roslaunch ros2lcm get_pose.launch - to launch gazebo, rviz, gmapping
  3. rosrun ros2lcm ros2lcm_node - to convcert ros to lcm messages 
  4. cd src/ros2lcm/src/Vulcan - This is the location of the already built binaries for Vulcan Package
  5. ./start_debug_ui - to open Vulcan Visualization
  
  To end the session, type ```exit```. 
  
  Optionally you can commit the changes, do the following. First, check the last container ID using:
  
  ```bash
  docker ps -lq
  ```
  
  Then run the following command to commit the changes:
  
  ```bash
  sudo docker commit <container ID> dockerv1
  ```
  Next time you start the session, any changes done previously will be saved.
# spatial_interaction
