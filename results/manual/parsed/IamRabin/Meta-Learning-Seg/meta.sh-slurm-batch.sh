#!/bin/bash
#SBATCH --job-name=Meta
#SBATCH --output=output/slurm.%N.%j.out
#SBATCH --error=output/slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=1-05:00:00
#SBATCH --partition=dgx2q

echo "== Starting run at $(date)"
echo "== Job ID: ${SLURM_JOBID}"
mkdir -p ~/output
srun python main.py --alg=iMAML
