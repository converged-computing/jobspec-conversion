#!/bin/bash
#FLUX: --job-name=hairy-truffle-9077
#FLUX: -c=32
#FLUX: --queue=pool
#FLUX: --urgency=16

  echo slurm node: $SLURMD_NODENAME , jobid: $SLURM_JOB_ID
  module load fiberseq-rs
  python fibseq_rust.py $1 $2
