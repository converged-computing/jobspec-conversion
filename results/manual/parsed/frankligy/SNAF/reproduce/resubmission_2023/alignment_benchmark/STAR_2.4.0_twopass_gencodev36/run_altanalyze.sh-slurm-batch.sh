#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/frankligy/SNAF/reproduce/resubmission_2023/alignment_benchmark/STAR_2.4.0_twopass_gencodev36/run_altanalyze.sh
