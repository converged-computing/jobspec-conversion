#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kutluaylab/SARS-2_COVID/alignment/bbduk_run_rp.sh
