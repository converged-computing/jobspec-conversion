#!/bin/bash
#SBATCH --job-name=groundgan
#SBATCH --account=hai_fedak
#SBATCH --output=output1000_100000_TFs10_GT0-%x.txt
#SBATCH --error=error1000_100000_TFs10_GT0-%x.txt
#SBATCH --mail-user=tejumade.afonja@cispa.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

nvidia-smi
export CUDA_VISIBLE_DEVICES=0,1,2,3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
source /p/project/hai_fedak/teju/GRouNdGAN/activate.sh
cd /p/project/hai_fedak/teju/GRouNdGAN
srun --exclusive python src/main.py --config /p/project/hai_fedak/teju/GRouNdGAN/configs/causal_gan.cfg --train&
wait
