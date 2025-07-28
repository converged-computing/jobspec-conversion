#!/bin/bash
#FLUX: --job-name=milky-bits-9069
#FLUX: -t=18000
#FLUX: --urgency=16

singularity exec -H /fp/projects01/account_name/abl_scm_perturbation_study/ docker/abl_scm_venv.sif python3 -u main.py $SLURM_ARRAY_TASK_ID 50
