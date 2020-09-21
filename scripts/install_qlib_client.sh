#!/bin/bash

sudo apt-get update
sudo apt-get install -y g++ nfs-common
MINICONDA=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
QLIB_CLIENT=https://github.com/microsoft/qlib.git
STOCK_DATA_DIR=/data/stock_data/qlib_data

CODE_DIR=$HOME/"code"
DOWNLOADS_DIR=$HOME/"downloads"
CONDA_DIR=$HOME/"miniconda3"

# create dir
if [ ! -d "$CONDA_DIR" ]; then
        mkdir $CONDA_DIR
fi

if [ ! -d "$CODE_DIR" ]; then
        mkdir $CODE_DIR
fi

if [ ! -d "$DOWNLOADS_DIR" ]; then
        mkdir $DOWNLOADS_DIR
fi

if [ ! -d "$STOCK_DATA_DIR" ]; then
        sudo mkdir -p $STOCK_DATA_DIR
fi

# install miniconda3
wget $MINICONDA -O $DOWNLOADS_DIR/"miniconda3.sh"
/bin/bash $DOWNLOADS_DIR/miniconda3.sh -b -u -p $CONDA_DIR

echo ". $CONDA_DIR/etc/profile.d/conda.sh" >> $HOME/.bashrc
echo "conda activate base" >> $HOME/.bashrc

# install qlib client
cd $CODE_DIR
git clone $QLIB_CLIENT
cd qlib
$CONDA_DIR/bin/pip install cython numpy
$CONDA_DIR/bin/python setup.py install
