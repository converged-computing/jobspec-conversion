#!/bin/bash
#SBATCH --job-name=spa_flow
#SBATCH --account=snic2019-3-630
#SBATCH --output=lunarc_output/outputs_spa_flow_%j.out
#SBATCH --error=lunarc_output/errors_spa_flow_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --time=01:00:00
#SBATCH --exclusive

ml load GCC/8.3.0
ml load CUDA/10.1.243
ml load OpenMPI/3.1.4
ml load PyTorch/1.6.0-Python-3.7.4
python /home/samwiq/spa/'seq-posterior-approx-w-nf-dev'/'two_moons'/run_script_spa_flow.py 1 2 $1 10
