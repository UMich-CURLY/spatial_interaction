# Base image
FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu16.04

# Setup basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    vim \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    libglfw3-dev \
    libglm-dev \
    libx11-dev \
    libomp-dev \
    libegl1-mesa-dev \
    pkg-config \
    wget \
    zip \
    net-tools \
    unzip &&\
    rm -rf /var/lib/apt/lists/*

#### Install conda new way ####

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN /root/miniconda3/bin/conda install numpy pyyaml scipy ipython mkl mkl-include &&\
    /root/miniconda3/bin/conda clean -ya 
ENV PATH /root/miniconda3/bin:$PATH

# Install cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.0/cmake-3.14.0-Linux-x86_64.sh
RUN mkdir /opt/cmake
RUN sh /cmake-3.14.0-Linux-x86_64.sh --prefix=/opt/cmake --skip-license
RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake
RUN cmake --version

# Conda environment
RUN conda create -n habitat python=3.7 cmake=3.14.0

# Setup habitat-sim
RUN git clone --branch v0.2.2 https://github.com/facebookresearch/habitat-sim.git
RUN /bin/bash -c ". activate habitat; cd habitat-sim; pip install -r requirements.txt; python setup.py install --headless --bullet"

# Install challenge specific habitat-lab
RUN git clone --branch v0.2.2 https://github.com/facebookresearch/habitat-lab.git
RUN /bin/bash -c ". activate habitat; cd habitat-lab; pip install -r requirements.txt; python setup.py develop --all; pip install pygame==2.0.1; pip install pybullet==3.0.4"

# Silence habitat-sim logs
ENV GLOG_minloglevel=2
ENV MAGNUM_LOG="quiet"

WORKDIR /home


RUN mkdir catkin_ws && cd catkin_ws && mkdir src && cd src
WORKDIR /home/catkin_ws/src

RUN git config --global user.email "tribhi@umich.edu"
RUN git config --global user.name "tribhi"
RUN git clone --recursive --branch single_robot https://github.com/UMich-CURLY/habitat_ros_interface.git
RUN git clone --recursive https://github.com/ros-teleop/teleop_twist_keyboard.git 
RUN conda create -n robostackenv python=3.9 -c conda-forge
RUN /bin/bash -c ". activate robostackenv; conda config --env --add channels conda-forge; conda config --env --add channels robostack-experimental; conda config --env --add channels robostack; conda config --env --set channel_priority strict"
RUN /bin/bash -c ". activate robostackenv; conda install -y ros-noetic-desktop"
RUN /bin/bash -c ". activate robostackenv; conda install -y ros-noetic-map-server"
RUN /bin/bash -c ". activate robostackenv; conda install -y ros-noetic-move-base"
RUN /bin/bash -c ". activate robostackenv; conda install -y ros-noetic-amcl"

RUN /bin/bash -c ". activate habitat; pip3 install gurobipy; pip3 install ortools pip install networkx; conda install -y IPython "
ENV ROS_MASTER_URI=http://172.17.0.1:11311
ENV ROS_IP=172.17.0.1
