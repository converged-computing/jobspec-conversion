#!/bin/bash
#FLUX: --job-name=Matlab_Gen_Parallel
#FLUX: -n=12
#FLUX: --queue=shas-testing
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load matlab
cd /projects/$USER/target_Directory
matlab -nosplash -nodesktop -r "clear; num_workers=$SLURM_NTASKS; parallel_std;"
