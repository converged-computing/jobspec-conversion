#!/bin/bash
#FLUX: --job-name=mapsim
#FLUX: --queue=debug-cpu
#FLUX: -t=14400
#FLUX: --urgency=16

module load anaconda
source activate tensorflow
python run_mapEnv.py
