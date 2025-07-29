#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/astro-informatics/casacore-1.7.0_patched/scons-tools/casacore_assay
