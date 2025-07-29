#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=4G
#SBATCH --time=10:00:00
#SBATCH --partition=gpu

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
