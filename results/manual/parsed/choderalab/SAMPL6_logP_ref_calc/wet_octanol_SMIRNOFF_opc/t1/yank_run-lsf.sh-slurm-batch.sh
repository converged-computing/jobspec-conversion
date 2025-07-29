#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/SAMPL6_logP_ref_calc/wet_octanol_SMIRNOFF_opc/t1/yank_run-lsf.sh
