#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/greenelab/phenoplier/nbs/15_gsa_gls/03_gtex_v8/03_05-genotype_dosage.sh
