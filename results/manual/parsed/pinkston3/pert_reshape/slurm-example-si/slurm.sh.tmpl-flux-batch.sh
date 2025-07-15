#!/bin/bash
#FLUX: --job-name=dirty-diablo-1562
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export OMP_NUM_THREADS='$cpus_per_task'
export OMP_PLACES='threads'
export OMP_PROC_BIND='true'

echo Job starts at `date`
echo Submit dir: $SLURM_SUBMIT_DIR
module load nvhpc/22.7
module load cray-hdf5
PERTURBO_BIN=/global/homes/d/donniep3/testbins/perturbo-hybrid-rev-acc-arred-8b.x
PERT_IN={{pert_in}}
mpi_tasks_per_node=4
cpus_per_node=$SLURM_CPUS_ON_NODE
total_nodes=$SLURM_NNODES
total_mpi_tasks=`expr $mpi_tasks_per_node \* $total_nodes`
cpus_per_task=`expr $cpus_per_node / $mpi_tasks_per_node`
export OMP_NUM_THREADS=$cpus_per_task
export OMP_PLACES=threads
export OMP_PROC_BIND=true
env
srun -N $total_nodes -n $total_mpi_tasks -c $cpus_per_task \
        --cpu_bind=cores --gpus-per-task=1 --gpu-bind=single:1 \
        $PERTURBO_BIN -npools $total_mpi_tasks -i $PERT_IN
echo Job ends at `date`
