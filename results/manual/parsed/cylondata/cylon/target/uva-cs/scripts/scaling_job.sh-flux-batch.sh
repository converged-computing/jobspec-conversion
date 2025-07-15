#!/bin/bash
#FLUX: --job-name=Cylon Scaling
#FLUX: -N=4
#FLUX: --queue=main
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='$DIR/bin:$PATH LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH PYTHONPATH=$DIR/lib/python3.9/site-packages'

DIR=$HOME/anaconda3/envs/cylon_dev
module load gcc-11.2.0 openmpi-4.1.4
conda activate cylon_dev
export PATH=$DIR/bin:$PATH LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH PYTHONPATH=$DIR/lib/python3.9/site-packages
which python gcc g++
mpirun -np 20 python cylon_scaling.py -n 35000000
