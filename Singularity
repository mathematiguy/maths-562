################# Header: Define the base system you want to use ################
# Reference of the kind of base you want to use (e.g., docker, debootstrap, shub).
Bootstrap: docker
# Select the docker image you want to use (Here we choose tensorflow)
From: texlive/texlive:latest-full-doc

# Environment variables that should be sourced at runtime.
%environment
        # use bash as default shell
        export SHELL=/bin/bash
        export LANG=en_CA.UTF-8
        export LANGUAGE=en_CA:en
        export LC_ALL=en_CA.UTF-8
        export LANG=en_CA.UTF-8
        export LC_CTYPE=en_CA.UTF-8
        export ACLANTHOLOGY=/code/submodules/acl-anthology
        export PYTHONPATH+=:$ACLANTHOLOGY/bin

################# Section: Defining the system #################################
# Commands in the %post section are executed within the container.
%post
        export DEBIAN_FRONTEND=noninteractive

        echo "Update apt packages"
        apt update -y

        echo "Setting locale"
        apt-get install -y locales tzdata git
        locale-gen en_CA.UTF-8
        dpkg-reconfigure locales
        echo "Canada/Eastern" > /etc/timezone
        dpkg-reconfigure -f noninteractive tzdata

        echo "Installing apt packages"
        apt-get update
        apt-get install -y curl \
                wget \
                unzip \
                software-properties-common \
                git \
                build-essential

        echo "Installing LaTeX packages..."
        tlmgr init-usertree && \
        tlmgr update --all
        tlmgr install koma-script

        echo "Creating mount points.."
        mkdir /dataset
        mkdir /tmp_log
        mkdir /final_log
