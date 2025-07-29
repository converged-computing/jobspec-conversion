#!/bin/bash
#SBATCH --output=/network/scratch/k/karam.ghanem/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=48G

module load miniconda/3 cuda/11.7
conda activate edm
python generate_sig_1.py
python generate_sig_2.py
python generate_sig_3.py
python generate_sig_4.py
cp $SLURM_TMPDIR  /network/scratch/k/karam.ghanem
