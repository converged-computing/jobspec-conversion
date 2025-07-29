#!/bin/bash
#SBATCH --job-name=96GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=128GB
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
            --overlay /scratch/jl14310/nanoGPTenv/nanoGPT.ext3:ro \
            /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif\
            /bin/bash -c "source /ext3/env.sh; \
            cd nanoGPT;\
            start_time=\$(date +%s); \
	    echo $start_time;\
	    export WANDB_MODE='offline'; \
            python train.py config/train_gpt2.py;\
            end_time=\$(date +%s); \
            echo Duration: \$((end_time - start_time)) seconds"
