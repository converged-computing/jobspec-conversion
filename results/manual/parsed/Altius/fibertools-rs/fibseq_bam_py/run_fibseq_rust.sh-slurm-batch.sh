#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G

  echo slurm node: $SLURMD_NODENAME , jobid: $SLURM_JOB_ID
  module load fiberseq-rs
  python fibseq_rust.py $1 $2
