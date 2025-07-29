#!/bin/bash
#SBATCH --job-name=TORCH-GPU
#SBATCH --output=$HOME_DIR/log/mri_sr.out.%j
#SBATCH --error=$HOME_DIR/log/mri_sr.err.%j
#SBATCH --mail-user=qi.wang@tuebingen.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx5000:2
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu
#SBATCH --chdir=$SRC_DIR

HOME_DIR='/u/wangqi'
SRC_DIR='/u/wangqi/git_wq/3d_super-resolution_mri/mains'
DATA_DIR='/ptmp/wangqi/LS_all/crops'
module purge 
module load anaconda/3/2021.11
module load gcc/11
module load openmpi/4
module load pytorch-distributed/gpu-cuda-11.6/2.0.0
module load pytorch-lightning/2.0.1
srun python ln_DDP_train.py --model_name 'DWT_D'
echo "Jobs finished"
