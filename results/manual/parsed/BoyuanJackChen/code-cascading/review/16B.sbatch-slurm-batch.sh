#!/bin/bash
#SBATCH --job-name=16B_review
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=100GB
#SBATCH --time=1-23:59:59
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
            --overlay /vast/bc3194/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif\
            /bin/bash -c "source /ext3/env.sh; export TRANSFORMERS_CACHE='/vast/bc3194/huggingface_cache'; python -u 16B.py"
