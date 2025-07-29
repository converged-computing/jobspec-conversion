#!/bin/bash
#SBATCH --mail-user=snodgras@iastate.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=36
#SBATCH: --no-requeue

module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core/
module load plink
plink --file NAM_rils_SNPs_allchr.plk --clump bQTL.padj_probgeno.bed
