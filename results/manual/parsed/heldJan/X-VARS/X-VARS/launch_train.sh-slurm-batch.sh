#!/bin/bash
#SBATCH --account=telim
#SBATCH --output=test2_mv.txt
#SBATCH --mail-user=jan.held@student.uliege.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=2
#SBATCH --time=04:05:00
#SBATCH --constraint=ntasks-per-node=1

source /gpfs/home/acad/ulg-intelsig/jheld/anaconda3/etc/profile.d/conda.sh
conda activate vars-ex
accelerate launch --config_file /gpfs/home/acad/ulg-intelsig/jheld/.cache/huggingface/accelerate/default_config.yaml training.py
