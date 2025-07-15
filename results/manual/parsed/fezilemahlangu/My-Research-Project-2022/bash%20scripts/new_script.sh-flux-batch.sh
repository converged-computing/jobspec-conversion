#!/bin/bash
#FLUX: --job-name=expressive-dog-9057
#FLUX: --urgency=16

echo "---------------------------"
echo "Job started on" `date`
source ~/.bashrc ##source conda 
conda activate my_env
conda config --env --add channels conda-forge 
echo "---------------------------"
echo "Job ended on" `date`
