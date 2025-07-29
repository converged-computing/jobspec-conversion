#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4g
#SBATCH --time=01:00:00
#SBATCH --partition=l40-gpu
#SBATCH --qos=gpu_access

export LD_LIBRARY_PATH='/nas/longleaf/home/wth12380/.conda/envs/RTensorFlow/lib/python3.10/site-packages/tensorrt_libs:$LD_LIBRARY_PATH'

module add anaconda/2023.03
module add cuda/11.4
module add r/4.1.3
export LD_LIBRARY_PATH=/nas/longleaf/home/wth12380/.conda/envs/RTensorFlow/lib/python3.10/site-packages/tensorrt_libs:$LD_LIBRARY_PATH
R CMD BATCH --no-restore 02-DeepGWAS_Kidney-train.R
