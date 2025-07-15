#!/bin/bash
#FLUX: --job-name=joyous-muffin-4353
#FLUX: --priority=16

echo "---------------------------"
echo "Job started on" `date`
source ~/.bashrc ##source conda 
conda config --env --add channels conda-forge 
python SL_python.py
echo "---------------------------"
echo "Job ended on" `date`
