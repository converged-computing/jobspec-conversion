#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/genepattern/nmf-gpu/wrapper/test/consensus_4x_mpi/4mpiTest.sp
