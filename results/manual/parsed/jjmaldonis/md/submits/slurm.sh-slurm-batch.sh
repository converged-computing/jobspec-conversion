#!/bin/bash
#FLUX: --job-name=NiP_MD
#FLUX: -n=16
#FLUX: --queue=stem
#FLUX: -t=604800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Date:"
date '+%s'
echo "Using ACI / HCP / Slurm cluster."
echo "JobID = $SLURM_JOB_ID"
echo "Using $SLURM_NNODES nodes"
echo "Using $SLURM_NODELIST nodes."
echo "Number of cores per node: $SLURM_TASKS_PER_NODE"
echo "Submit directory: $SLURM_SUBMIT_DIR"
echo ""
module load compile/intel
module load mpi/intel/openmpi-1.10.2
module load lammps-31Jan14
module list
mpiexec lmp_linux < $1
echo "Finished on:"
date '+%s'
