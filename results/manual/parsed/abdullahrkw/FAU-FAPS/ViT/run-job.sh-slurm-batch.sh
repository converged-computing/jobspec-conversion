#!/bin/bash
#SBATCH --job-name=FAU-FAPS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx3080:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=2

unset SLURM_EXPORT_ENV
source /home/hpc/iwfa/iwfa018h/.bashrc
conda activate FAPS
python main.py --model cvit --epochs ${epochs} --problem ${problem} --lr ${lr} --batch-size ${batch}
echo ${epochs}_${problem}_${lr}_${batch}
