#!/bin/bash
#FLUX: --job-name=scheduler
#FLUX: -c=2
#FLUX: --queue=cluster-name
#FLUX: -t=518400
#FLUX: --urgency=16

while getopts f:e: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;  # specified as -f
        e) envname=${OPTARG};;   # specified as -e
    esac
done
source $HOME/anaconda3/bin/activate $envname
PYTHONPATH=$PWD dask-scheduler --scheduler-file $filename
