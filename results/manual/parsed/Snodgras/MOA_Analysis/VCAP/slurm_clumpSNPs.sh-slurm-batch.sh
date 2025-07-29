#!/bin/bash
#SBATCH --mail-user=snodgras@iastate.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=36
#SBATCH: --no-requeue

module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core/
module load plink
plink --bfile NAM_rils_SNPs_allchr --clump bQTL.padj_probgeno.numeric.bed --clump-kb 0.150 --clump-r2 0.99 --clump-field P --clump-p1 0.1 --clump-p2 0.3 -out NAM_rils_SNPs.padj_probgeno.clumped
