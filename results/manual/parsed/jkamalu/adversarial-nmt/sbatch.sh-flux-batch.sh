#!/bin/bash
#FLUX: --job-name="bert-vanilla-hidden"
#FLUX: --queue=jag-standard
#FLUX: --priority=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
srun --nodes=${SLURM_NNODES} bash -c 'source /nlp/u/jkamalu/miniconda3/bin/activate && conda activate adversarial-nmt && python run.py --mode train --experiment bert-vanilla-hidden.yml'
echo "Done"
