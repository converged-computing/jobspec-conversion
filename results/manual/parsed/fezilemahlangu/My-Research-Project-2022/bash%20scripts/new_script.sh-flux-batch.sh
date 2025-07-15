#!/bin/bash
#FLUX: --job-name=scruptious-poodle-3538
#FLUX: --priority=16

echo "---------------------------"
echo "Job started on" `date`
source ~/.bashrc ##source conda 
conda activate my_env
conda config --env --add channels conda-forge 
echo "---------------------------"
echo "Job ended on" `date`
