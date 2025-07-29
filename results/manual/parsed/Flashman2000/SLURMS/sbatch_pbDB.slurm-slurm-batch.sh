#!/bin/bash
#SBATCH --mail-user=vst14@case.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=4-04:00:00
#SBATCH --constraint=gpup100

module purge
module load parabricks/3.1.1 singularity/3.5.1 cuda/10.1
cd /mnt/rds/txl80/LaframboiseLab/vst14/AR_BAM/
bash /mnt/rds/txl80/LaframboiseLab/vst14/pbtest_DB.sh
