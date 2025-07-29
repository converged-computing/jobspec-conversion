#!/bin/bash
#SBATCH --job-name=sPhysNet
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:mi50:1
#SBATCH --mem=8GB
#SBATCH --time=1-00:00:00

module purge
singularity exec \
    --overlay ~/conda_envs/pytorch1.11-rocm4.5.2-25GB-500K.sqf:ro \
    /scratch/work/public/hudson/images/rocm4.5.2-ubuntu20.04.3.sif \
    bash -c "source /ext3/env.sh; export PYTHONPATH=../dataProviders:$PYTHONPATH; python train_rd_split.py --config_name $1 " $1
