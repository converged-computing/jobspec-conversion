#!/bin/bash
#SBATCH --job-name=eta1_alpha=0.0001_h_dim=9_keep_prob=0.6
#SBATCH --account=chenGrp
#SBATCH --output=jobs_oe/eta1_alpha=0.0001_h_dim=9_keep_prob=0.6-%j.o
#SBATCH --error=jobs_oe/eta1_alpha=0.0001_h_dim=9_keep_prob=0.6-%j.e
#SBATCH --mail-user=xue20@wfu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=8

echo $(pwd) > "jobs/pwd.txt"
source /deac/csc/chenGrp/software/tensorflow/bin/activate
python run.py --num 1 --alpha 0.0001 --h_dim 9 --keep_prob 0.6 --data eta1 --k 6 --beta 1.0 --kmeans 1 --main_epoch 1000
