#!/bin/bash
#FLUX: --job-name=gloopy-underoos-1317
#FLUX: -c=12
#FLUX: -t=28800
#FLUX: --urgency=16

export CRAFT='/home/ban115/craft/craft/'
export PATH='$CRAFT/cuda-fdmt/cudafdmt/src:$CRAFT/python:$PATH:/home/ban115/bin:$CRAFT/jobs/'
export PYTHONPATH='$CRAFT/python:$PYTHONPATH'
export OMP_NUM_THREADS='24'

export CRAFT=/home/ban115/craft/craft/
export PATH=$CRAFT/cuda-fdmt/cudafdmt/src:$CRAFT/python:$PATH:/home/ban115/bin:$CRAFT/jobs/
export PYTHONPATH=$CRAFT/python:$PYTHONPATH
export OMP_NUM_THREADS=24
module unload PrgEnv-cray > /dev/null
module unload gcc/4.9.0
module load python/2.7.10 > /dev/null
module load astropy > /dev/null
thedir=$1
thebase=`basename $thedir`
echo `date` starting fixheaders
CRAFTDATA=/scratch2/askap/askapops/craft/co/
aprun -B fix_headers_parallel.sh  $@
echo `date` finished fixheaders
