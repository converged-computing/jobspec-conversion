#!/bin/bash
#FLUX: --job-name=h2o
#FLUX: -t=600
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'

export SLURM_CPU_BIND="cores"
srun --mpi=pmi2 shifter --image=docker:deepmodeling/deepmd-kit:2.2.7_cuda11.6_gpu --module gpu --volume="$(pwd):/workspace" --workdir="/workspace" bash -c "lmp -in in.lammps -log log"
