#!/bin/bash
#FLUX: --job-name=unstableabl
#FLUX: -N=20
#FLUX: --queue=standard
#FLUX: -t=35999
#FLUX: --urgency=16

export OMP_NUM_THREADS='1  # Max hardware threads = 4'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module purge
source /projects/hfm/lcheung/spack-manager/environments/test2/load.sh
ranks_per_node=36
mpi_ranks=$(expr $SLURM_JOB_NUM_NODES \* $ranks_per_node)
export OMP_NUM_THREADS=1  # Max hardware threads = 4
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
EXE=amr_wind
exawind_exec=`which $EXE`
CONFFILE=ATLVINEYARD_test1.inp
echo "Job name       = $SLURM_JOB_NAME"
echo "Num. nodes     = $SLURM_JOB_NUM_NODES"
echo "Num. MPI Ranks = $mpi_ranks"
echo "Num. threads   = $OMP_NUM_THREADS"
echo "Working dir    = $PWD"
echo "EXE            = $exawind_exec"
srun -n ${mpi_ranks} -c 1  --cpu_bind=cores ${exawind_exec} ${CONFFILE}
