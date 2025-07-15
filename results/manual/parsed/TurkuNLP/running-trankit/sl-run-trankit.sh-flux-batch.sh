#!/bin/bash
#FLUX: --job-name=chunky-spoon-2063
#FLUX: --urgency=16

mkdir -p logs
echo "START: $(date)"
echo "installing venv"
python3 -m venv venv-trankit
source venv-trankit/bin/activate
echo "venv done"
echo 
pip3 install --upgrade pip
pip3 install setuptools-rust
pip3 install trankit==1.1.0
pip3 install transformers
echo "Parsing"
cat $1 | srun python3 parse.py | gzip > output.conllu.gz
