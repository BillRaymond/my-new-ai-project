FROM ubuntu:22.04

# Define the version of Python to install
# "3.11" will the latest, like 3.11.1, 3.11.2, etc
ARG PYVER="3.11"

# Define GitHub settings
# If you use GitHub, GitLab, or a similar service
# you might want to use the same username and email
ARG GITUN="Change Me"
ARG GITEMAIL="change.me@changeme.somedomain"

# These settings prevent a timezone prompt when Python installs
# Use this article to find your time zone (TZ):
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
ENV TZ=US/Pacific \
    DEBIAN_FRONTEND=noninteractive

# Update the apt repo
RUN apt update

# Install Python dependencies and Python
# Learn about the deadsnakes Personal Package Archives, hosted by Ubuntu: 
# https://www.youtube.com/watch?v=Xe40amojaXE
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get install -y python$PYVER \
    python3-pip

# Set PYVER as the default Python interpreter
RUN update-alternatives --install /usr/bin/python3 python /usr/bin/python$PYVER 1
RUN update-alternatives --set python /usr/bin/python$PYVER

# Upgrade packages to the latest version
RUN apt-get -y upgrade && \
    pip install --upgrade pip

# Install AI and ML tools
RUN apt-get install -y gcc python$PYVER-dev && \
    pip install numpy \
    matplotlib \
    pandas \
    tensorflow \
    scikit-learn \
    jupyterlab \
    notebook

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Optionally install and configure Git
# Note: Modify your username and email
#       with the ARGs in this DockerFile
RUN apt-get install -y git-all

# Configure git
RUN git config --global user.name "$GITUN" &&\
    git config --global user.email $GITEMAIL &&\
    git config --global init.defaultBranch main
