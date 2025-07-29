#!/bin/bash
#SBATCH --account=csci_ga_2572_2023sp_19
#SBATCH --output=logs/data_checks.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --partition=n1s8-v100-1
#SBATCH: --exclusive

singularity exec --nv --overlay overlay-15GB-500K.ext3:ro\
    -B data/dataset_v2.sqsh:/dataset:image-src=/\
    -B /scratch\
    /share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif\
   /bin/bash -c 'source /ext3/env.sh; python check_system.py'
