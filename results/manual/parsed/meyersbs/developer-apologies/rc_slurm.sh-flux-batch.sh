#!/bin/bash
#FLUX: --job-name=devaps1
#FLUX: --queue=tier3
#FLUX: -t=18000
#FLUX: --urgency=16

echo "Loading environment"
spack env activate mistakes-21091601
echo "Installing pip"
python3 -m ensurepip --upgrade
echo "Installing coverage"
pip3 install --user coverage
echo "Installing spacy model"
python3 -m spacy download en_core_web_sm
