#!/bin/bash
#SBATCH --job-name=devaps2
#SBATCH --account=mistakes
#SBATCH --output=dev_apologies2.stdout
#SBATCH --error=dev_apologies2.stderr
#SBATCH --mail-user=bsm9339@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50g
#SBATCH --time=04:00:00
#SBATCH --partition=tier3

echo "Loading environment"
spack env activate mistakes-21091601
echo "Installing pip"
python3 -m ensurepip --upgrade
echo "Installing coverage"
pip3 install --user coverage
echo "Installing spacy model"
python3 -m spacy download en_core_web_sm
echo "Checking JavaScript..."
date
time python3 -u main.py info_data data_850_stars/JavaScript/
date
