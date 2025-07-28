#!/bin/bash
#FLUX: --job-name=crusty-cattywampus-2272
#FLUX: -c=8
#FLUX: --queue=long
#FLUX: -t=72000
#FLUX: --urgency=16

module load anaconda
conda activate conda_env
python test14.py 
