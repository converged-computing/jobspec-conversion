#!/bin/bash
#SBATCH --output=test.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000
#SBATCH --time=00:01:00

module load singularity/2.4.2
hostname
nvidia-smi
/home/steinba/development/nvidia-samples/9.0.176/1_Utilities/deviceQuery/deviceQuery
singularity exec --nv /scratch/steinba/tf1.5.simg /home/steinba/development/nvidia-samples/9.0.176/1_Utilities/deviceQuery/deviceQuery
