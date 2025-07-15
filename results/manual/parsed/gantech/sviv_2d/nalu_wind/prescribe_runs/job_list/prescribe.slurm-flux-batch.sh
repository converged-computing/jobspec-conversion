#!/bin/bash
#FLUX: --job-name=prescribed
#FLUX: -t=14400
#FLUX: --priority=16

export SPACK_MANAGER='~/spack-manager'

export SPACK_MANAGER=~/spack-manager
source ${SPACK_MANAGER}/start.sh
spack-start
spack env activate -d ~/spack-manager/environments/sviv_prescribe/ 
spack load nalu-wind
caselist=$(printf "list_of_cases_%02d" ${SLURM_ARRAY_TASK_ID})
for i in `cat ${caselist}`
do
    cd $i
    srun -n 10 naluX -i *.yaml &> log 
    cd -
done
wait
