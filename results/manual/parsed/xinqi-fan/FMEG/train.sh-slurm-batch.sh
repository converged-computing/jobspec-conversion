#!/bin/bash
#SBATCH --output=/home/xinqifan2/Project/first-order-model/hpc/train_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB

module load gcc openmpi/4.0.5/gcc/8.3.0
module load cuda/11.0.2 cuda/blas/11.0.2 cuda/fft/11.0.2
source activate pytorch160
nvidia-smi
cd /home/xinqifan2/Project/first-order-model
python run.py --config config/samm-256.yaml --checkpoint checkpoints_samm/vox-cpk.pth.tar
