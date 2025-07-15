#!/bin/bash
#FLUX: --job-name=butterscotch-cattywampus-1494
#FLUX: -t=600
#FLUX: --urgency=16

module load pytorch/1.8.1-py39-cuda112-mpi
source /scratch1/wan410/venv/bin/activate                                             # use the virtual environment
python3 GP_sampler_NPF.py
