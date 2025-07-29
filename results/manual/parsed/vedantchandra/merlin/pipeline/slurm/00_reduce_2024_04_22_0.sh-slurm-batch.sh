#!/bin/bash
#SBATCH --job-name=r2024_04_22
#SBATCH --output=/n/holyscratch01/conroy_lab/vchandra/mage/logs/reduce/reduce_2024_04_22_v0.out
#SBATCH --error=/n/holyscratch01/conroy_lab/vchandra/mage/logs/reduce/reduce_2024_04_22_v0.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4500
#SBATCH --time=05:00:00
#SBATCH --constraint=intel

source activate pypeit2
cd /n/home03/vchandra/outerhalo/08_mage/pipeline/
echo 'CPU USED: ' 
cat /proc/cpuinfo | grep 'model name' | head -n 1
echo 'QUEUE NAME:' 
echo $SLURM_JOB_PARTITION
echo 'NODE NAME:' 
echo $SLURMD_NODENAME 
python -u radagast.py --dir=/n/holystore01/LABS/conroy_lab/Lab/vchandra/mage/data/2024_04_22/ --version=0  --skipred=False
