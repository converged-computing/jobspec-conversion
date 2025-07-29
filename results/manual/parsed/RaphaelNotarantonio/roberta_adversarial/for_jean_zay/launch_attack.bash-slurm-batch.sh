#!/bin/bash
#SBATCH --job-name=pgd
#SBATCH --output=pgd_attack%j.out
#SBATCH --error=pgd_attack%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

cd ${SLURM_SUBMIT_DIR}
module purge
module load pytorch-gpu/py3/1.6.0
srun python ./attack.py   
