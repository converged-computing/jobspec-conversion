#!/bin/bash
#FLUX: --job-name=MD_Vol
#FLUX: -n=16
#FLUX: --queue=univ
#FLUX: -t=604800
#FLUX: --urgency=16

echo "Using ACI / HCP / Slurm cluster."
echo "JobID = $SLURM_JOB_ID"
echo "Using $SLURM_NNODES nodes"
echo "Using $SLURM_NODELIST nodes."
echo "Number of cores per node: $SLURM_TASKS_PER_NODE"
echo "Submit directory: $SLURM_SUBMIT_DIR"
echo ""
mpiexec /usr/lammps-31Jan14/src/lmp_linux
