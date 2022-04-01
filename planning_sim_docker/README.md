# habitat_multi_docker
Install docker-ce and then install the NVIDIA Container Toolkit using this link:
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

Finally, run these commands to clone this repo and build an image:

```bash
cd ~
git clone https://github.com/UMich-CURLY/habitat_multi_docker.git
cd habitat_multi_docker
sudo docker build --tag dockerv1 .
```
To load the data in your container, make sure you have the Matterport data saved in the cloned repository. You can download the data from habitat_lab repository https://github.com/facebookresearch/habitat-lab. if you save the path outside of thr current repository of the shell script, make sure to change the path to the data on your machine to be loaded correctly in your docker container.
Finally, Run the bash file as follows:

```bash
cd habitat_multi_docker/
sudo chmod +x launch_docker.sh
sudo ./launch_docker.sh
```
  
  Inside your docker container, you will find that all the associated code it in the right path.
  
  Namely we have two repositories in our docker path:
  
  1. tour_mathing_routing
  2. habitat_ros_interface

  Moreover there are 2 conda environments in your docker environment. 
  1. habitat - Based in python3.7 and runs all the files related to habitat_sim and habitat_lab
  2. robostackenv - Based in python3.9 and runs everything in ros noetic
 
  Once you're in your docker continue to run the following statements 
  
  ```bash
    . activate robostackenv
    cd /home/catkin_ws
    catkin_make
    source /home/catkin_ws/devel/setup.bash
    roslaunch habitat_interface default.launch
  ```
  
  This should have set up your ros interface with habitat. Now lets start our simulator threads.
  In another terminal inside your docker (docker exec -it <container_id> /bin/bash), run the following:
  
  ```bash
    . activate habitat
    cd /home/catkin_ws/src/habitat_ros_interface
    ./launch_robots.bash
  ```

Finally you should see your three robots in the Rviz window that is open for you. To start the tour planner, "Publish Point" andwhere in the map. This will show the calculated path for the robots, and also execute them. 
