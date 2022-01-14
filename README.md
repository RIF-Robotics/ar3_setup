# About

Setup instructions and docker files for AR3.

# AR3 Setup

## Install Dependencies:

* Docker: https://docs.docker.com/engine/install/ubuntu/
* docker-compose: https://docs.docker.com/compose/install/
* vcs: http://wiki.ros.org/vcstool

I prefer `sudo apt install python3-vcstool` using the ROS repositories

## First Time Instructions

1. Setup Workspace and Clone ar3_setup

        $ mkdir -p ~/ros2/ar3_ws/src
        $ cd ~/ros2/ar3_ws
        $ git clone git@github.com:RIF-Robotics/ar3_setup.git

2.  Clone Repositories

        $ cd ~/ros2/ar3_ws/ar3_setup
        $ vcs import ../src < ar3.repos

    **NOTE**: Regularly execute the following to keep the repositories up to
    date:

        $ vcs pull ../src

3. Build Docker development environment

        $ cd ~/ros2/ar3_ws/ar3_setup
        $ docker-compose build

## Use Docker Development Environment

Start Docker development environment and enter:

    $ cd ~/ros2/ar3_ws/ar3_setup
    $ docker-compose up -d dev-nvidia
    $ docker exec -it ar3_galactic_nvidia /bin/bash

**NOTE**: You can open as many terminals as needed with the last command. Each
command will drop you inside the same container.

Stop Docker container

    $ cd ~/ros2/ar3_ws/ar3_setup
    $ docker-compose stop

Remove container (will remove any of your changes in the Docker container, so
don't do this unless you want to start fresh):

    $ cd ~/ros2/ar3_ws/ar3_setup
    $ docker-compose down

## AR3 in Simulation (with a pre-built map)

Coming soon
