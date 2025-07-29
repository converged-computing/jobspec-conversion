#!/bin/bash
#SBATCH --job-name=MD_Vol
#SBATCH --output=Zr50Cu35Al15_sm_tot.%J.out
#SBATCH --error=Zr50Cu35Al15_sm_tot.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=16

echo "Using ACI / HCP / Slurm cluster."
echo "JobID = $SLURM_JOB_ID"
echo "Using $SLURM_NNODES nodes"
echo "Using $SLURM_NODELIST nodes."
echo "Number of cores per node: $SLURM_TASKS_PER_NODE"
echo "Submit directory: $SLURM_SUBMIT_DIR"
echo ""
mpiexec /usr/lammps-31Jan14/src/lmp_linux
< Zr50Cu35Al15_sm_tot.in
