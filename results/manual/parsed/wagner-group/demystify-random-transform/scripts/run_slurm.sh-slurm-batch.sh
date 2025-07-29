#!/bin/bash
#SBATCH --job-name=rand-smooth
#SBATCH --account=fc_wagner
#SBATCH --output=slurm-%j-test-pgd-rand-35-fix-order-1235-aggmo.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:GTX2080TI:2
#SBATCH --time=1-00:00:00

eval "$(conda shell.bash hook)"
conda activate base
python test.py configs/test_img_rand_fixed.yml
