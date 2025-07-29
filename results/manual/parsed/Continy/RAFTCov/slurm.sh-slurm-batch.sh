#!/bin/bash
#SBATCH --job-name=StereoCov
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --mail-user=satanama.ring@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=3-00:23:00

EXE=/bin/bash
singularity exec --nv --bind /data2/datasets/wenshanw/tartan_data:/zihao/datasets:ro,/data2/datasets/yuhengq/zihao/RAFTCov:/zihao/RAFTCov /data2/datasets/yuhengq/zihao/flowformer_v1.1.sif bash /zihao/RAFTCov/script.sh
