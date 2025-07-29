#!/bin/bash
#SBATCH --job-name=ISBI_UNet
#SBATCH --mail-user=qc690@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:2
#SBATCH --mem=32000
#SBATCH --time=1-16:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load all
module load cuda/10.0
source activate py362
cd /scratch/qc690/Video/MS_Lesion_seg
python  -u train_UNet_ISBI.py>Log/log_UNet_ISBI.txt
