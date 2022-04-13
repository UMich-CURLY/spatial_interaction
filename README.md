# spatial_interaction
This repository contains our work on developing an interactive mapping and planning pipeline for socially assistive robots. We use the photo-realistic Habitat-sim as the simulation environment for running this framework. Our framework consists of a mapping and a planning module, each of which are included here in two separate dockers. Our topological graph is build inside the mapping docker that resturns the voronoi paths between any two points in our enviuronments, which we call the global plan. The local planner then can then execute these plans. For an interactive system, we encode preferences of where the human is interested in going and then finally plan a tour of environment. The tour planner and the simulation environment are run together in the planning docker. In the given video that is sped up 4x, our tour planner returns the shortest path that is feasible within user constraints and turns them to the global and local planner, that then execute the plan. 
![alt text](./small_tour.gif)
<br />
<center><img src="./Diagram_width.png" width="850"></center>

Our input sensors are RGB-D cameras only, we estimate odometry using a visual odometry pipeline in rtabmap_ros package. The system is amenable to be used with a range of different sensors that may be on board, 3D LiDAR, 2D Laser, IMU, etc. that will only improve the performance further. 

# Running our code 
We work on two separate docker environments and set the master as your host PC. For visualizations to work, we enable our docker to use the system GPU. To do so: Install docker-ce and then install the NVIDIA Container Toolkit using this link:
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

# vulcan_docker


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
