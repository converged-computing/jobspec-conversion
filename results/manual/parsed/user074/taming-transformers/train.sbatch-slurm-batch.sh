#!/bin/bash
#SBATCH --job-name=taming
#SBATCH --account=csci_ga_3033_102-2023fa
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=10GB
#SBATCH --time=04:00:00
#SBATCH --partition=n1c24m128-v100-4
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv --overlay /scratch/jq394/imageTokenizer/taming.ext3:ro /share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif /bin/bash -c "source /ext3/env.sh; conda activate taming; bash train_taming.sh"
