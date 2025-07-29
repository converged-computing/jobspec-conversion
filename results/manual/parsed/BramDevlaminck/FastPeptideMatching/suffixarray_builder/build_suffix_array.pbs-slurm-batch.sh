#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/BramDevlaminck/FastPeptideMatching/suffixarray_builder/build_suffix_array.pbs
