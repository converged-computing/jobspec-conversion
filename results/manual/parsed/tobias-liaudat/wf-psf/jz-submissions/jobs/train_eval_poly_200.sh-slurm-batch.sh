#!/bin/bash
#SBATCH --job-name=2c_poly_train_eval
#SBATCH --account=xdy@gpu
#SBATCH --output=2c_poly_train_eval%j.out
#SBATCH --error=2c_poly_train_eval%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
cd $WORK/repo/wf-psf/jz-submissions/slurm-logs/
srun python ./../scripts/train_eval_poly_200.py
