FROM dorowu/ubuntu-desktop-lxde-vnc

MAINTAINER q907305684 

RUN mv /etc/apt/sources.list /etc/apt/sources.list.copy

RUN echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse' >> /etc/apt/sources.list && \ 
    echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse' >> /etc/apt/sources.list && \ 
    echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse' >> /etc/apt/sources.list

# Install python-wxgtk2.8
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main universe" | tee /etc/apt/sources.list.d/trusty-copies.list && \
    apt-get update && \
    apt-get -y install python-wxgtk2.8 && \
    rm /etc/apt/sources.list.d/trusty-copies.list
    
# Install packages needed for app
RUN apt-get update && \
    apt-get remove -y vim-common && \
    apt-get install -y vim \
                       curl \
                       wget \
                       build-essential \	
                       python-pip \
                       python-dev \
                       python-lxml \
                       libjpeg8-dev \
                       zlib1g-dev \
                       libfreetype6-dev \
                       libaio-dev \
                       python-matplotlib \ 
                       fcitx \
                       fcitx-googlepinyin \
                       fcitx-module-cloudpinyin \
                       fcitx-sunpinyin \
                       language-pack-gnome-zh-hans  \
                       ttf-wqy-zenhei
                       
RUN ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib && \
    ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib && \
    ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib

# 处理中文问题
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN.UTF-8

# 处理时区问题
RUN echo "Asia/shanghai" > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

#########################################
##          Install app components     ##
#########################################
RUN pip install -U -i https://pypi.tuna.tsinghua.edu.cn/simple setuptools \
                   robotframework==3.0.4 \
                   numpy \
                   pillow \
                   opencv_contrib_python \
                   imagehash \
                   sympy \
                   xlrd \
                   docutils \
                   Pygments \
                   pyyaml \
                   Paver \
                   invoke \
                   cx_Oracle \
                   requests \               
                   Appium-Python-Client \
                   robotframework-requests \
                   robotframework-appiumlibrary \
                   robotframework-seleniumlibrary \
                   robotframework-ride==1.5.2.1 \
                   robotframework-ftplibrary \
                   robotframework-databaselibrary \
                   robotframework-httplibrary \
                   robotframework-difflibrary \
                   robotframework-faker \
                   robotframework-rfdoc \
                   robotframework-lint \
                   robotframework-pageobjects \
                   robotframework-pycurllibrary 

RUN mkdir -p /root/.local/share/
