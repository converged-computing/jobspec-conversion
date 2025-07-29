#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dianaicd/GenomicsMetagenomics_IndigenousBrazil/Admixture/optim_ngsAdmix_array.sh
