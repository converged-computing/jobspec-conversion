#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/isabella232/cyclecloud-lammps/specs/default/cluster-init/files/run_lammps_mpi.sh
