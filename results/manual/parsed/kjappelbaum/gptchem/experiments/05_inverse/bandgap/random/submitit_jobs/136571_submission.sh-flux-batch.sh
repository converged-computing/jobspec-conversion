#!/bin/bash
#FLUX: --job-name=submitit
#FLUX: --queue=LocalQ
#FLUX: -t=3600
#FLUX: --priority=16

export SUBMITIT_EXECUTOR='slurm'

export SUBMITIT_EXECUTOR=slurm
srun --unbuffered --output /home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs/%A_%a_%t_log.out --error /home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs/%A_%a_%t_log.err /home/kevin/miniconda3/envs/gpt3/bin/python -u -m submitit.core._submit /home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs
