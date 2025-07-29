#!/bin/bash
#SBATCH --job-name=plink
#SBATCH --account=berglandlab
#SBATCH --output=/scratch/aob2x/ld/logs/ld.%A_%a.out
#SBATCH --error=/scratch/aob2x/ld/logs/ld.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=00:15:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

module load plink/1.90b6.16
cd /scratch/aob2x/ld
plink \
--r2 inter-chr with-freqs yes-really \
--double-id --allow-extra-chr \
--ld-window-r2 0.01 \
--vcf /scratch/aob2x/ld/CM_pops.AllChrs.Whatshap.shapeit.annot.wSNPids.vcf.gz \
--ld-snp-list /project/berglandlab/jcbnunez/Shared_w_Alan/in2lt_ld_47snps_informative_markers.txt \
