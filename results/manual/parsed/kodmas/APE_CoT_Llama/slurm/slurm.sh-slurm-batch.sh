#!/bin/bash
#SBATCH --job-name=APE_test_1
#SBATCH --account=MST112195
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:8
#SBATCH --mem=16384
#SBATCH --partition=gp1d
#SBATCH --constraint=ntasks-per-node=4

module load miniconda3
conda info --envs
huggingface-cli whoami
conda activate /home/kodmas2023/miniconda3/envs/ape
python ../experiments/run_instruction_induction.py --task=informal_to_formal
