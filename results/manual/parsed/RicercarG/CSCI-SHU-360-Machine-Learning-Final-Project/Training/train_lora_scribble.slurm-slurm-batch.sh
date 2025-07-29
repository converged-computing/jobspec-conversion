#!/bin/bash
#SBATCH --job-name=train_lora
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=32GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python/intel/3.8.6
singularity exec --nv --bind /scratch/yg2709 --overlay /scratch/yg2709/ml_project_env/overlay-25GB-500K.ext3:ro /scratch/yg2709/ml_project_env/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif/ /bin/bash -c "
source /ext3/env.sh
pwd
cd /scratch/yg2709/CSCI-SHU-360-Machine-Learning-Final-Project
accelerate launch train_lora_scribble.py
exit
"
