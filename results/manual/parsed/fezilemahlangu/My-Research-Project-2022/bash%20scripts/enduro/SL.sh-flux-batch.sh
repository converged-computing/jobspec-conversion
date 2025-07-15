#!/bin/bash
#FLUX: --job-name=hairy-onion-2184
#FLUX: --urgency=16

echo "---------------------------"
echo "Job started on" `date`
source ~/.bashrc ##source conda 
conda config --env --add channels conda-forge 
python SL_python.py
echo "---------------------------"
echo "Job ended on" `date`
