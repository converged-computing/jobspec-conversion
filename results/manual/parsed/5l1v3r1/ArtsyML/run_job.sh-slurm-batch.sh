#!/bin/bash
#SBATCH --job-name=artsy
#SBATCH --output=TitanV.txt
#SBATCH --error=stderr.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --partition=gpu_p
#SBATCH --qos=normal
#SBATCH --nodelist=supergpu03pxe

export PATH='/usr/local/cuda-10.1/bin:$PATH'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64'
export TFHUB_CACHE_DIR='./tmp'

source ~/.bashrc
export PATH=/usr/local/cuda-10.1/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64
export TFHUB_CACHE_DIR=./tmp
conda activate artsyml
python video_stream_benchmark_parallel.py
