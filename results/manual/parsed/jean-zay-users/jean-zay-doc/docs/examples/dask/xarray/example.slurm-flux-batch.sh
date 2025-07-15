#!/bin/bash
#FLUX: --job-name=xarray
#FLUX: -c=2
#FLUX: --queue=prepost
#FLUX: -t=72000
#FLUX: --urgency=16

cd /path/to/your/scratch/folder
module purge
module load anaconda-py3/2021.05
conda activate /path/to/conda/environment
echo `which python`
python example.py
