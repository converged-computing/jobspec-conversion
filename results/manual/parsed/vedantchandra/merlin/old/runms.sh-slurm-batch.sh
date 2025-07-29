#!/bin/bash
#SBATCH --job-name=fitMAGE
#SBATCH --account=conroy_lab
#SBATCH --output=logs/msfit_%a.out
#SBATCH --error=logs/msfit_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3500
#SBATCH --time=00:03:00
#SBATCH --partition=conroy_priority,itc_cluster,shared,serial_requeue
#SBATCH --constraint=intel
#SBATCH --array=0-79

module load python
source /n/home03/vchandra/.bashrc
source activate outerhalo
cd /n/home03/vchandra/outerhalo/08_mage/
python -u 01_runstar.py "${SLURM_ARRAY_TASK_ID}" --version='h3'
