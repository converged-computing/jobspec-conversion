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
        *) echo "usage: $0 [-f] [-e]"
           echo "  -f: filename of scheduler file"
           echo "  -e: name of conda environment"
           exit 1 ;;
    esac
done
source "$HOME/anaconda3/bin/activate" "$envname"
PYTHONPATH=$PWD dask-scheduler --scheduler-file "$filename"
