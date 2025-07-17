#!/bin/bash
#FLUX: --job-name=angry-chair-0985
#FLUX: -n=6
#FLUX: -t=600
#FLUX: --urgency=16

MEMORY_PER_TASK=$(( $SLURM_CPUS_PER_TASK*$SLURM_MEM_PER_CPU ))
echo SLURM_NTASKS: $SLURM_NTASKS  
echo SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE
echo SLURM_CPUS_PER_TASK: $SLURM_CPUS_PER_TASK 
echo SLURM_NNODES: $SLURM_NNODES
echo SLURM_MEM_PER_CPU: $SLURM_MEM_PER_CPU
module load cesga/2020 gcc/system openmpi/4.0.5_ft3_cuda dask/2022.2.0
rm -f scheduler_info.txt
rm -f ssh_command.txt
TASKS_FOR_CLUSTER=$((SLURM_NTASKS-1))
echo 'TASKS_FOR_CLUSTER= '$TASKS_FOR_CLUSTER
srun -n $SLURM_NTASKS \
    -c $SLURM_CPUS_PER_TASK \
    --mem=$MEMORY_PER_TASK \
	--resv-ports=$TASKS_FOR_CLUSTER -l \
    ./wraper.sh
    #python ./dask_cluster_resvports.py -local $LUSTRE_SCRATCH --dask_cluster 
