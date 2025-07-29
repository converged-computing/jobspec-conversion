#!/bin/bash
#SBATCH --job-name=roberta-flash-attention
#SBATCH --output=/home/rwg642/flash-roberta/roberta-flash-attention.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=8000M
#SBATCH --time=00:20:00
#SBATCH --exclude=hendrixgpu01fl

module load miniconda/4.12.0
conda init bash
conda activate kiddothe2b
echo $SLURMD_NODENAME
echo $CUDA_VISIBLE_DEVICES
python demo_mlm.py --model_class roberta
echo "----------------------------------------"
python demo_mlm.py --model_class flash-roberta
