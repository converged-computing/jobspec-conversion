#!/bin/bash
#FLUX: --job-name=mpi_job_test
#FLUX: -n=2
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/petsc/petsc-3.13.4-dbg/lib:/usr/lib64:$LD_LIBRARY_PATH'

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
module load mvapich2/2.3.3-gcc-8.3.1
export LD_LIBRARY_PATH="/opt/petsc/petsc-3.13.4-dbg/lib:/usr/lib64:$LD_LIBRARY_PATH"
echo $LD_LIBRARY_PATH
mpiexec -np 2 ./iFluid -d 2 -p 2 1 -i in-cyl2d-VREMAN-advterm -o out-cyl2d-test
    #srun --mpi=pmi2 ./iFluid -d 2 -p 2 1 -i in-cyl2d-VREMAN-advterm -o out-cyl2d-test
