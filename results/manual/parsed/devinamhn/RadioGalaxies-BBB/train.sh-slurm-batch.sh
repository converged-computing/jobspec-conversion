#!/bin/bash
#SBATCH --job-name=vi
#SBATCH --output=/share/nas2/dmohan/bbb/RadioGalaxies-BBB/exps/logs/out-slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:23:00
#SBATCH --constraint=A100,ntasks-per-node=1
#SBATCH --exclude=compute-0-116,compute-0-117,compute-0-118,compute-0-119,compute-0-7

pwd;
nvidia-smi
echo ">>>start"
source /share/nas2/dmohan/bbb/RadioGalaxies-BBB/venv/bin/activate 
echo ">>>training"
python /share/nas2/dmohan/bbb/RadioGalaxies-BBB/mirabest_bbb.py
