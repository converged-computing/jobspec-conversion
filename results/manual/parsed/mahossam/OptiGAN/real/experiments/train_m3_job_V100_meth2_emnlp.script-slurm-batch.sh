#!/bin/bash
#SBATCH --job-name=RelGAN_Job
#SBATCH --account=pb90
#SBATCH --output=RelGAN_job-%j.out
#SBATCH --error=RelGAN_job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=10000
#SBATCH --time=3-00:00:00

nvidia-smi
. /home/mahmoudm/anaconda3/etc/profile.d/conda.sh
conda activate tf_new_py3
pwd
date
python emnlp_small_relgan_meth2.py 0 0
date
