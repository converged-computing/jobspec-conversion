#!/bin/bash
#FLUX: --job-name={job_id}
#FLUX: -t=300
#FLUX: --priority=16

./pbrt --experiment ao_prog ${SLURM_ARRAY_TASK_ID}
