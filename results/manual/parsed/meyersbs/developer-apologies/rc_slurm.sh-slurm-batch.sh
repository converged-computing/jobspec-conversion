#!/bin/bash
#SBATCH --job-name=devaps1
#SBATCH --account=mistakes
#SBATCH --output=devaps1.stdout
#SBATCH --error=devaps1.stderr
#SBATCH --mail-user=bsm9339@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200g
#SBATCH --time=05:00:00

echo "Loading environment"
spack env activate mistakes-21091601
echo "Installing pip"
python3 -m ensurepip --upgrade
echo "Installing coverage"
pip3 install --user coverage
echo "Installing spacy model"
python3 -m spacy download en_core_web_sm
