FROM ros:melodic
RUN apt-get update && apt-get install -y \
    ros-melodic-desktop-full \
    ros-melodic-openslam-gmapping \
    ros-melodic-tf2-sensor-msgs \
    ros-melodic-people-msgs \
    ros-melodic-robot-controllers\
    git \
    x11-apps \
    mesa-utils \
    libgl1-mesa-glx \
    apt-utils \
    ros-melodic-fetch-gazebo-demo

RUN apt-get update && apt-get -y install rsync

# Installing Vulcan packages

RUN sudo apt-get install -y \
    wget \
    git \
    scons \
    doxygen \
    texlive-latex-extra \
    libboost-all-dev \
    libarmadillo-dev \
    libwxgtk3.0-gtk3-dev \
    libwxgtk-media3.0-gtk3-dev \
    libf2c2-dev \
    openjdk-8-jdk \
    libusb-dev \
    libusb-1.0-0-dev \
    libpopt-dev \
    libsdl1.2-dev \
    libsdl-net1.2-dev \
    libopencv-dev \
    cmake \
    autoconf

# Installing rtabmap
RUN sudo apt-get update && apt install -y\
    ros-melodic-laser-scan-matcher \
    ros-melodic-rtabmap-ros \
    ros-melodic-hector-slam

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        libxau6 libxau6:i386 \
        libxdmcp6 libxdmcp6:i386 \
        libxcb1 libxcb1:i386 \
        libxext6 libxext6:i386 \
        libx11-6 libx11-6:i386 && \
    rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
        ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64


RUN git clone -b master https://github.com/UMich-CURLY/ros2lcm.git /root/catkin_ws/src/ros2lcm/
# RUN git clone -b master https://github.com/tribhi/umma-project.git /root/catkin_ws/src/umma-project/
RUN git clone -b master https://github.com/tribhi/gmapping_withpose.git /root/catkin_ws/src/slam_gmapping/
RUN git clone -b main https://gitlab.eecs.umich.edu/tribhi/topomapping_code /root/catkin_ws/src/ros2lcm/src/Vulcan
# RUN git clone -b main https://github.com/Theochiro/Museum_docent.git /root/catkin_ws/src/Museum_docent/
# RUN git clone --recursive -b master https://github.com/leggedrobotics/darknet_ros.git /root/catkin_ws/src/darknet_ros/

WORKDIR /root/catkin_ws/src/ros2lcm/src/Vulcan
RUN ./install.sh
RUN ./install.sh
RUN scons build/bin/local_topo_hssh -j12

# RUN scons -j4
# WORKDIR /root/catkin_ws/src/Museum_docent/fetch_gazebo/scripts/
# RUN chmod +x prepare_simulated_robot.py 
RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc


WORKDIR /root/catkin_ws/src/ros2lcm/src/Vulcan
ENV ROS_MASTER_URI=http://172.17.0.1:11311
ENV ROS_IP=172.17.0.1
ENV DISPLAY=unix$DISPLAY
ENV LIBGL_ALWAYS_INDIRECT=1
