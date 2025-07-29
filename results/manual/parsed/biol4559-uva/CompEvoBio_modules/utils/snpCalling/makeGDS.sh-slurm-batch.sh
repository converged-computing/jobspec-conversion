#!/bin/bash
#SBATCH --job-name=manual_annotate
#SBATCH --account=biol4559-aob2x
#SBATCH --output=/scratch/aob2x/compBio_SNP_25Sept2023/logs/manual_annotate.%A_%a.out
#SBATCH --error=/scratch/aob2x/compBio_SNP_25Sept2023/logs/manual_annotate.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

Rscript --vanilla /scratch/aob2x/CompEvoBio_modules/utils/snpCalling/scatter_gather_annotate/vcf2gds.R \
/scratch/aob2x/compBio_SNP_25Sept2023/dest.expevo.PoolSNP.001.50.11Oct2023.norep.ann.vcf.gz
