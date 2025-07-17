#!/bin/bash
#FLUX: --job-name=Final
#FLUX: -c=28
#FLUX: -t=432000
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 1000
module load cuda10.0/toolkit/10.0.130 # loading cuda libraries/drivers 
module load python/intel/3.7          # loading python environment
env_out_file=outputs/environment.out
module load python/intel/3.7          # loading python environment
module load anaconda
source /cm/shared/apps/anaconda3/etc/profile.d/conda.sh
conda activate base
conda create -n Arash-project python=3.7 -c conda-forge -y -q > $env_out_file
echo "(Arash-project) environment created" >> $env_out_file
conda activate Arash-project
conda install -c conda-forge mamba -y -q >> $env_out_file
echo "mamba installed" >> $env_out_file
mamba env update -n Arash-project -f environment.yml --prune -q >> $env_out_file
conda activate Arash-project
echo "(Arash-project) environment updated" >> $env_out_file
echo "Running scripts..."
python3 ./setup.py -q develop
echo "(autosegment) installed development environment" >> $env_out_file
python3 Model_proj_final.py
conda activate base
