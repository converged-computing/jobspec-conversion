#!/bin/bash
#FLUX: --job-name=[*
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

module load singularity
module load intel-mpi-19
cd $SLURM_SUBMIT_DIR
mpiexec singularity run [* YOUR SIF IMAGE NAME *] collective/osu_gather
