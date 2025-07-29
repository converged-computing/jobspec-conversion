#!/bin/bash
#SBATCH --job-name=KGQG-bart-5e4
#SBATCH --output=slurmouts/slurm_output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:4
#SBATCH --mem=32000M
#SBATCH --time=2-00:00:00

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
source venv/bin/activate
TOKENIZERS_PARALLELISM=false srun python -u main.py --gpus -1 --batch_size 2 --learning_rate 5e-4 --max_epochs 300 \
                                         --optimizer adafactor --dataset PQ --logdir bart_PQ --pre_trained bart
