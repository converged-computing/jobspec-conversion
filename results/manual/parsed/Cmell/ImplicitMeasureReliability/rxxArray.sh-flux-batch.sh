#!/bin/bash
#FLUX: --job-name=Run_3-MPI
#FLUX: -N=10
#FLUX: --queue=shas
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load R/3.3.0
module load openmpi/1.10.2
DATE=$(date +%Y-%m-%d_%H.%M.%S)
let ncores=SLURM_NTASKS
let taskId=SLURM_ARRAY_TASK_ID
echo "Number of cores:" $ncores
ESTFL="Results/est_group${taskId}.RData"
mpiexec -np $ncores Rscript rxx031mpi.R --n.iter=10000 --dateStr=$DATE --guideFl=FullGuide.RData --estFlNm=$ESTFL --group=$taskId
