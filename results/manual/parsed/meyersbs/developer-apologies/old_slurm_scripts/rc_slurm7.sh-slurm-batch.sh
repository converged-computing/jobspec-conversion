#!/bin/bash
#SBATCH --job-name=devaps7
#SBATCH --account=mistakes
#SBATCH --output=dev_apologies7.stdout
#SBATCH --error=dev_apologies7.stderr
#SBATCH --mail-user=bsm9339@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=200g
#SBATCH --time=1-00:00:00
#SBATCH --partition=tier3

echo "Loading environment"
spack env activate mistakes-21091601
echo "Installing pip"
python3 -m ensurepip --upgrade
date
echo "Installing spacy model"
python3 -m spacy download en_core_web_sm
date
echo "Doing stuff..."
time python3 -u scripts/count_apologies.py data_test/ 48
date
