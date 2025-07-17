#!/bin/bash
#FLUX: --job-name=QSIprep
#FLUX: --queue=small,amdsmall
#FLUX: -t=86400
#FLUX: --urgency=16

cd run_files.QSIprep
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
