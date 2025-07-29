#!/bin/bash
#FLUX: --job-name=dask_control
#FLUX: -c=2
#FLUX: --queue=some_queue,some_other_queue
#FLUX: -t=172800
#FLUX: --urgency=16

module load python
python run_psweep.py
