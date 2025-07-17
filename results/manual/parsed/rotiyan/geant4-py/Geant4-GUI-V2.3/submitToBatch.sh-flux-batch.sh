#!/bin/bash
#FLUX: --job-name=arid-cherry-5839
#FLUX: --queue=htc
#FLUX: -t=14400
#FLUX: --urgency=16

module load singularity 
module load spack
singularity exec -B /cvmfs:/cvmfs -B /hpc:/hpc /users/rnarayan/Public/geant4-10.6_latest.sif $1 $SLURM_ARRAY_TASK_ID
