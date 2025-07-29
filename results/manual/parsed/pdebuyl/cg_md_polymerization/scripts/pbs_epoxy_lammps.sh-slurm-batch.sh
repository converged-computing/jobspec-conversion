#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pdebuyl/cg_md_polymerization/scripts/pbs_epoxy_lammps.sh
