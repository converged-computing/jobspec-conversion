#!/bin/bash
#SBATCH --job-name=example
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=1500
#SBATCH --time=00:04:00
#SBATCH --constraint=ntasks-per-socket=1

ww721@ese-hivemind:/raid/hivemind$ cat slurmTemplate20.sh 
source ~/miniconda3/etc/profile.d/conda.sh
conda activate testgpu
python xavier.py 0&
python xavier.py 1&
wait
exit 0
