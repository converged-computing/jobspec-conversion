#!/bin/bash
#SBATCH --job-name=TORCH-GPU
#SBATCH --output=./log/torch.out.%j
#SBATCH --error=./log/torch.err.%j
#SBATCH --mail-user=qi.wang@tuebingen.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu
#SBATCH --chdir=./

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
srun python /u/wangqi/torch_env/crop_gan/test_crop_new.py --path /ptmp/wangqi/MPI_subj3/crops --subj MPRAGE --scale 2
echo "Jobs finished"
