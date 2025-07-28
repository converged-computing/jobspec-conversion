#!/bin/bash
#FLUX: --job-name=expressive-frito-6791
#FLUX: -c=32
#FLUX: --queue=pool
#FLUX: --urgency=16

  echo slurm node: $SLURMD_NODENAME , jobid: $SLURM_JOB_ID
  module load fiberseq-rs
  python fibseq_rust.py $1 $2
