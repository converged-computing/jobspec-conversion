#!/bin/bash
#FLUX: --job-name=phat-despacito-9623
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

print_usage() {
  printf "Usage: -f feature flags, -p preprocessing flags, -k kernel size"
}
while getopts "f:p:k:d:" arg; do
  case $arg in
    f) feature_flags=$(echo "$OPTARG" | tr ',' ' ');;
    p) preprocessing_flag=$OPTARG;;
    k) kernel_size=$OPTARG;;
    d) directory=$OPTARG;;
    *) print_usage
       exit 1;;
  esac
done
. ./env.sh
module load pytorch/1.13
pip install matplotlib tqdm gif scikit-learn ptflops
train.py -i $(pwd)/data -o $(pwd)/$directory/$SLURM_JOB_NAME --gpus 0 --num-workers 6 --epochs 10000 --batch-size 10 $feature_flags $preprocessing_flag --kernel-size $kernel_size
