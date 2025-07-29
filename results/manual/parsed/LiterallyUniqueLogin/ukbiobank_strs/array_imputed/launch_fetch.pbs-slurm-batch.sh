#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LiterallyUniqueLogin/ukbiobank_strs/array_imputed/launch_fetch.pbs
