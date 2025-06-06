#!/bin/sh

#SBATCH --job-name=MD_Vol                  # job name
#SBATCH --partition=univ                # default "univ" if not specified
#SBATCH --error=Zr50Cu35Al15_sm_tot.%J.err              # error file
#SBATCH --output=Zr50Cu35Al15_sm_tot.%J.out             # output file
#SBATCH --input Zr50Cu35Al15_sm_tot.in

#SBATCH --time=7-00:00:00               # run time in days-hh:mm:ss

#SBATCH --nodes=1                      # number of nodes requested (n)
#SBATCH --ntasks=16                     # required number of CPUs (n)
#SBATCH --ntasks-per-node=16             # default 16 (Set to 1 for OMP)
#SBATCH --cpus-per-task=1              # default 1 (Set to 16 for OMP)
##SBATCH --mem=16384                    # total RAM in MB, max 64GB  per node
##SBATCH --mem-per-cpu=4000              # RAM in MB (default 4GB, max 8GB)

##SBATCH --export=ALL

echo "Using ACI / HCP / Slurm cluster."
echo "JobID = $SLURM_JOB_ID"
echo "Using $SLURM_NNODES nodes"
echo "Using $SLURM_NODELIST nodes."
echo "Number of cores per node: $SLURM_TASKS_PER_NODE"
echo "Submit directory: $SLURM_SUBMIT_DIR"
echo ""

# Executable
mpiexec /usr/lammps-31Jan14/src/lmp_linux

