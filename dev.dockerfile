FROM osrf/ros:rolling-desktop

MAINTAINER Kevin DeMarco
ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y ros-rolling-gazebo-ros \
    && rm -rf /var/lib/apt/lists/*

# Create the "ros" user, add user to sudo group
ENV USERNAME ros
RUN adduser --disabled-password --gecos '' $USERNAME \
    && usermod  --uid 1000 $USERNAME \
    && groupmod --gid 1000 $USERNAME \
    && usermod --shell /bin/bash $USERNAME \
    && adduser $USERNAME sudo \
    && adduser $USERNAME dialout \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $USERNAME

RUN mkdir -p /home/$USERNAME/workspace/src

WORKDIR /home/$USERNAME/workspace

# Copy code in
COPY --chown=ros ./src ./src

# Install code dependencies
RUN sudo apt-get update \
    && sudo rosdep update \
    && sudo rosdep install --from-paths src --ignore-src -r -y --rosdistro=rolling

# Build code
RUN source /opt/ros/rolling/setup.bash \
    && colcon build --symlink-install

# Setup .bashrc environment
RUN echo 'source ~/workspace/install/setup.bash' >> /home/$USERNAME/.bashrc \
    && echo 'source /usr/share/gazebo/setup.sh' >> /home/$USERNAME/.bashrc \
    && mkdir -p /home/$USERNAME/workspace/src
