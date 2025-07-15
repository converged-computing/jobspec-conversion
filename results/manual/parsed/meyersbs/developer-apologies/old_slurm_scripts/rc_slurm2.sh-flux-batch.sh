#!/bin/bash
#FLUX: --job-name=conspicuous-truffle-9816
#FLUX: --priority=16

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
