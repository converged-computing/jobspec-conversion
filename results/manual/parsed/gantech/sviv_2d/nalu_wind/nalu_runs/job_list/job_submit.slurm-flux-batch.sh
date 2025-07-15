#!/bin/bash
#FLUX: --job-name=af_smd
#FLUX: -N=11
#FLUX: -t=172800
#FLUX: --urgency=16

export SPACK_MANAGER='~/spack-manager'

export SPACK_MANAGER=~/spack-manager
source ${SPACK_MANAGER}/start.sh
spack-start
spack env activate -d ~/spack-manager/environments/sviv_smd_run/ 
spack load nalu-wind
line_str=$(printf '%dp' ${SLURM_ARRAY_TASK_ID})
directory=$(sed -n $line_str list_of_cases)
printf "%s\n" $directory
cd $directory
srun -n 396 naluX -i *.yaml &> log 
