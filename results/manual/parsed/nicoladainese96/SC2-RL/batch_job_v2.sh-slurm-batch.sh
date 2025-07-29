#!/bin/bash
#SBATCH --account=project_2001281
#SBATCH --mail-user=nicola.dainese@aalto.fi
#SBATCH --mail-type=FAIL,REQUEUE,TIME_LIMIT_80
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --partition=gpu

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python monobeast_v2.py $*
