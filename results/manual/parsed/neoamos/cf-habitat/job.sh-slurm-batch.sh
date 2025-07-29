#!/bin/bash
#SBATCH --job-name=test-hab
#SBATCH --output=/home/an38gezy/thesis/cf-habitat/data/experiments/job_out/job.out.%j
#SBATCH --error=/home/an38gezy/thesis/cf-habitat/data/experiments/job_out/job.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=3600
#SBATCH --time=00:10:00
#SBATCH --constraint=dgx

module purge
module load gcc cuda
nvidia-smi 1>&2
cd /home/an38gezy/thesis/cf-habitat
python main.py --run-type both --exp-config configs/experiments/crazyflie_baseline_rgb.yaml
