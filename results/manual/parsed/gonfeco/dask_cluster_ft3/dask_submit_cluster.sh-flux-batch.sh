#!/bin/bash
#FLUX: --job-name=persnickety-kitty-4711
#FLUX: --priority=16

MEMORY_PER_TASK=$(( $SLURM_CPUS_PER_TASK*$SLURM_MEM_PER_CPU ))
echo SLURM_NTASKS: $SLURM_NTASKS  
echo SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE
echo SLURM_CPUS_PER_TASK: $SLURM_CPUS_PER_TASK 
echo SLURM_NNODES: $SLURM_NNODES
echo SLURM_MEM_PER_CPU: $SLURM_MEM_PER_CPU
echo MEMORY_PER_TASK: $MEMORY_PER_TASK
module load cesga/2020 gcc/system openmpi/4.0.5_ft3_cuda dask/2022.2.0
rm -f scheduler_info.txt
rm -f ssh_command.txt
srun -n $SLURM_NTASKS \
    -c $SLURM_CPUS_PER_TASK \
	--resv-ports=$SLURM_NTASKS -l \
    --mem=$MEMORY_PER_TASK \
    python ./dask_cluster.py \
        -local $LUSTRE_SCRATCH \
        --dask_cluster \
        --ib \
        #-scheduler_file $SCHED_FILE \
        #-preload  ./PreLoad.py
