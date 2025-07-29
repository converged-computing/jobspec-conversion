#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ornl-languages/osb/Graph500/contrib/pbs/run_huge_page_mpi.pbs
