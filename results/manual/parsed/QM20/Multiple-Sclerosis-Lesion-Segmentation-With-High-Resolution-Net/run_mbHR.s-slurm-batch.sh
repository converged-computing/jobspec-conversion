#!/bin/bash
#SBATCH --job-name=mbHRNet
#SBATCH --mail-user=qc690@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --mem=32000
#SBATCH --time=1-16:00:00
#SBATCH --partition=nvidia
#SBATCH --constraint=ntasks-per-node=1

module purge
module load all
module load cuda/10.0
cd /home/qc690/Video/MS_Lesion_Seg
/home/qc690/anaconda3_3.4.1/bin/python  -u train_mbHRNet.py>log_mbHRNet_samedataset.txt
