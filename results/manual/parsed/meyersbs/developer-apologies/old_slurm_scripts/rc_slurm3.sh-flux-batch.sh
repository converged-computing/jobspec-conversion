#!/bin/bash
#FLUX: --job-name=grated-lemon-4989
#FLUX: --urgency=16

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
