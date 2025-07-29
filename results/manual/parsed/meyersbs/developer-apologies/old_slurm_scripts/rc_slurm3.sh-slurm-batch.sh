#!/bin/bash
#SBATCH --job-name=devaps3
#SBATCH --account=mistakes
#SBATCH --output=dev_apologies3.stdout
#SBATCH --error=dev_apologies3.stderr
#SBATCH --mail-user=bsm9339@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50g
#SBATCH --time=01:00:00

echo "Loading environment"
spack env activate mistakes-21091601
echo "Installing pip"
python3 -m ensurepip --upgrade
echo "Installing coverage"
pip3 install --user coverage
echo "Installing spacy model"
python3 -m spacy download en_core_web_sm
echo "Loading Clojure..."
date
time python3 -u main.py load experiment.hdf5 data_850_stars/Clojure/
time python3 -u main.py info_hdf5 experiment.hdf5
date
