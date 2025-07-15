#!/bin/bash
#FLUX: --job-name=postcode_finder
#FLUX: -c=4
#FLUX: -t=600
#FLUX: --priority=16

cd "${SLURM_SUBMIT_DIR}"
echo Running on host "$(hostname)"
echo Time is "$(date)"
echo Start Time is "$(date)"
echo Directory is "$(pwd)"
echo Slurm job ID is "${SLURM_JOBID}"
echo This jobs runs on the following machines:
echo "${SLURM_JOB_NODELIST}"
source activate cc_project
python debugging_2024.py
echo End Time is"$(date)"
