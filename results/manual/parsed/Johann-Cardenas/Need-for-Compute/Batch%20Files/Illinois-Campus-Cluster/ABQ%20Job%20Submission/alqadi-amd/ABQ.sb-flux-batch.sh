#!/bin/bash
#FLUX: --job-name=NB1DSUMW
#FLUX: -c=16
#FLUX: --queue=alqadi-amd
#FLUX: -t=345600
#FLUX: --urgency=16

module use /projects/eng/modulefiles
module load abaqus/2023
module load intel/20.4
module load cuda/11.1
unset SLURM_GTIDS
abaqus inp=NB1DSUMW job=NB1DSUMW user=UMAT scratch=/scratch/users/johannc2/NB1DSUMW cpus=16 gpus=1 mp_mode=mpi memory=200000mb interactive
module unload cuda/11.1
module unload intel/20.4
module unload abaqus/2023
