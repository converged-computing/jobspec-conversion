#!/bin/bash
#FLUX: --job-name=bumfuzzled-butter-6815
#FLUX: --urgency=16

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
