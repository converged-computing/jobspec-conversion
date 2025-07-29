#!/bin/bash
#SBATCH --job-name=torch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=2GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
	    --overlay /scratch/wbg231/capstone_env/overlay-15GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "source /ext3/env.sh; python txgn/example.py"
