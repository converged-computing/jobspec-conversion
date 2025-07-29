#!/bin/bash
#SBATCH --job-name=permutations-transformer-training
#SBATCH --account=punim2163
#SBATCH --mail-user=mpetschack@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64000
#SBATCH --time=7-00:00:00
#SBATCH --partition=gpu-a100

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
source ./venv/bin/activate
python ./main.py
my-job-stats -a -n -s
