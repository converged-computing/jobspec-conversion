#!/bin/bash
#SBATCH --job-name=devaps12
#SBATCH --account=mistakes
#SBATCH --output=dev_apologies12.stdout
#SBATCH --error=dev_apologies12.stderr
#SBATCH --mail-user=bsm9339@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200g
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=32

echo "Loading environment"
spack env activate mistakes-21091601
echo "Doing stuff..."
time python3 -u main.py apology_stats data_aps/ 32
date
