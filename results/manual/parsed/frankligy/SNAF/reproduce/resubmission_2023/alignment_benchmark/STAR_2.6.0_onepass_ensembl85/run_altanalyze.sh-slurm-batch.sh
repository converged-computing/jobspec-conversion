#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/frankligy/SNAF/reproduce/resubmission_2023/alignment_benchmark/STAR_2.6.0_onepass_ensembl85/run_altanalyze.sh
