#!/bin/bash
#SBATCH --job-name=moai_step1000_archv4_lr1e3_moai23
#SBATCH --output=moai_step1000_archv4_lr1e3_moai23.out
#SBATCH --error=moai_step1000_archv4_lr1e3_moai23.err
#SBATCH --mail-user=pselvaraju@cs.umass.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gypsum-titanx

module load cuda11/11.2.1
python train_multi.py --cfg './src/configs/config_moaiparamdiffusion.yml' 
