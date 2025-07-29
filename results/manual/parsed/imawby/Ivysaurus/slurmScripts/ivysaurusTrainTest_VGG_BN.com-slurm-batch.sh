#!/bin/bash
#SBATCH --mail-user=i.mawby1@lancaster.ac.uk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:2
#SBATCH --mem=150G
#SBATCH --time=06:00:00
#SBATCH --partition=astro

source /etc/profile
echo 'BEGIN'
echo Job running on compute node `uname -n`
cd /home/hpc/30/mawbyi1/Ivysaurus
module add cuda
module add anaconda3-gpu
source activate opence_env
python TrainIvysaurus.py '1'
echo 'DONE'
