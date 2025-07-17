#!/bin/bash
#FLUX: --job-name=worker
#FLUX: --queue=cluster-name
#FLUX: -t=518400
#FLUX: --urgency=16

while getopts f:e:w: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;    # specified as -f
        e) envname=${OPTARG};;     # specified as -e
        w) workername=${OPTARG};;  # specified as -w
        *) echo "usage: $0 [-f] [-e] [-w]"
           echo "  -f: filename of scheduler file"
           echo "  -e: name of conda environment"
           echo "  -w: name of worker"
           exit 1 ;;
    esac
done
source "$HOME/anaconda3/bin/activate" "$envname"
PYTHONPATH=$PWD dask-worker \
  --scheduler-file "$filename" \
  --name "$workername" \
  --resources "GPU=1" \
  --no-nanny
