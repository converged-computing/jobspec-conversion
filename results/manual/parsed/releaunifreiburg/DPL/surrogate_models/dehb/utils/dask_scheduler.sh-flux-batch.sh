#!/bin/bash
#FLUX: --job-name=rainbow-pot-1210
#FLUX: --priority=16

while getopts f:e: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;  # specified as -f
        e) envname=${OPTARG};;   # specified as -e
    esac
done
source $HOME/anaconda3/bin/activate $envname
PYTHONPATH=$PWD dask-scheduler --scheduler-file $filename
