#!/bin/bash
#FLUX: --job-name=hello
#FLUX: -n=64
#FLUX: -t=120
#FLUX: --urgency=16

source /cluster/bin/jobsetup
module purge   # clear any inherited modules
set -o errexit # exit on errors
module load singularity/2.5.0
module load openmpi.gnu/1.10.2
mpirun singularity exec -B /work:/work  ~/ubuntu.simg /usr/bin/hello
