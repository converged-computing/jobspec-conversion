#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/eragasa/pyflamestk/examples/lmps_MgO_mpi_uniform/anl_concurrent_lammps.pbs
