#!/bin/bash
#FLUX: --job-name=bdt-map
#FLUX: --queue=thrun
#FLUX: -t=86400
#FLUX: --priority=16

python -u run_experiment.py -j ${SLURM_ARRAY_TASK_ID}
