#!/bin/bash
#FLUX: --job-name=purple-punk-3285
#FLUX: --priority=16

while getopts f:e:w: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;    # specified as -f
        e) envname=${OPTARG};;     # specified as -e
        w) workername=${OPTARG};;  # specified as -w
    esac
done
source $HOME/anaconda3/bin/activate $envname
PYTHONPATH=$PWD dask-worker --scheduler-file $filename --name $workername --resources "GPU=1" --no-nanny
