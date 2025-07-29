#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/liangyy/ukb_idp_genetic_arch/methods/prscs/02-split_genotype.sh
