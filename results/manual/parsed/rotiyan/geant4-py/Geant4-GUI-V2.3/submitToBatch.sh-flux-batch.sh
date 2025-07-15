#!/bin/bash
#FLUX: --job-name=fuzzy-leader-4111
#FLUX: -t=14400
#FLUX: --priority=16

module load singularity 
module load spack
singularity exec -B /cvmfs:/cvmfs -B /hpc:/hpc /users/rnarayan/Public/geant4-10.6_latest.sif $1 $SLURM_ARRAY_TASK_ID
