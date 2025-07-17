#!/bin/bash
#FLUX: --job-name=12statsCE
#FLUX: --queue=phillips
#FLUX: -t=54000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load java easybuild GATK bedtools samtools
diploSHIC="/projects/phillipslab/ateterina/scripts/diploSHIC/diploSHIC.py"
ref="/projects/phillipslab/ateterina/CE_haw_subset/ref_245/c_elegans.PRJNA13758.WS245.genomic.fa"
VCF="CE_population_filt_snps_5-100_0.5_fin.vcf"
MASK="CE_mask_these_region5-100_0.5.bed"
name=${MASK/_these_region/}
cd /projects/phillipslab/ateterina/CE_haw_subset/data/BAMS
bedtools maskfasta -fi $ref -bed $MASK -fo ${name/.bed/.fasta}
samtools faidx ${name/.bed/.fasta}
python $diploSHIC fvecVcf --winSize 100000 --maskFileName ${name/.bed/.fasta} --unmaskedFracCutoff 0.10 --numSubWins 1 diploid $VCF I 15072434 ${VCF/.vcf/}.NOPHASE.I.100K.0.1.stats
python $diploSHIC fvecVcf --winSize 100000 --maskFileName ${name/.bed/.fasta} --unmaskedFracCutoff 0.10 --numSubWins 1 diploid $VCF II 15279421 ${VCF/.vcf/}.NOPHASE.II.100K.0.1.stats
python $diploSHIC fvecVcf --winSize 100000 --maskFileName ${name/.bed/.fasta} --unmaskedFracCutoff 0.10 --numSubWins 1 diploid $VCF III 13783801 ${VCF/.vcf/}.NOPHASE.III.100K.0.1.stats
python $diploSHIC fvecVcf --winSize 100000 --maskFileName ${name/.bed/.fasta} --unmaskedFracCutoff 0.10 --numSubWins 1 diploid $VCF IV 17493829 ${VCF/.vcf/}.NOPHASE.IV.100K.0.1.stats
python $diploSHIC fvecVcf --winSize 100000 --maskFileName ${name/.bed/.fasta} --unmaskedFracCutoff 0.10 --numSubWins 1 diploid $VCF V 20924180 ${VCF/.vcf/}.NOPHASE.V.100K.0.1.stats
python $diploSHIC fvecVcf --winSize 100000 --maskFileName ${name/.bed/.fasta} --unmaskedFracCutoff 0.10 --numSubWins 1 diploid $VCF X 17718942 ${VCF/.vcf/}.NOPHASE.X.100K.0.1.stats
