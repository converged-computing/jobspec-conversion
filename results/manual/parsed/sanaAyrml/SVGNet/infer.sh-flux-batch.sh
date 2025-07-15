#!/bin/bash
#FLUX: --job-name=mode_6
#FLUX: -c=20
#FLUX: -t=14400
#FLUX: --priority=16

module load gcc/8.4.0-cuda  python/3.7.7
source /work/vita/sadegh/argo/argo-env/bin/activate
python -V
python inference.py 
