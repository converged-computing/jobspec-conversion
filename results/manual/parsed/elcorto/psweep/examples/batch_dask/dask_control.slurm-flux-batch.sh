#!/bin/bash
#FLUX: --job-name=dask_control
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --priority=16

module load python
python run_psweep.py
