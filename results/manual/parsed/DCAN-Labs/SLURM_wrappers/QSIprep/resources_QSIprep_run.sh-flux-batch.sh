#!/bin/bash
#FLUX: --job-name=loopy-nalgas-4702
#FLUX: --urgency=16

cd run_files.QSIprep
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
