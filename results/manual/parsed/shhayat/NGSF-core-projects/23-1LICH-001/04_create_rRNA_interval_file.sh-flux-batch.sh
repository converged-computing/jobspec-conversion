#!/bin/bash
#FLUX: --job-name=rrna_intervals
#FLUX: -t=1200
#FLUX: --urgency=16

set -eux
module load nixpkgs/16.09 
module load gcc/5.4.0
module load intel/2016.4
module load intel/2017.1
module load bedtools
GTF=/datastore/NGSF001/analysis/references/human/gencode-40/gencode.v40.annotation.gtf
OUTDIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/23-1LICH-001/analysis/rrna_intervals
mkdir -p ${OUTDIR}
grep 'rRNA' ${GTF} > ${OUTDIR}/rRNA_transcripts.gtf
/globalhome/hxo752/HPC/anaconda3/envs/gtfToGenePred/bin/gtfToGenePred ${OUTDIR}/rRNA_transcripts.gtf ${OUTDIR}/rRNA_transcripts.genePred
/globalhome/hxo752/HPC/anaconda3/envs/genepredtobed/bin/genePredToBed ${OUTDIR}/rRNA_transcripts.genePred ${OUTDIR}/rRNA_intervals.bed
bedtools merge -i ${OUTDIR}/rRNA_intervals.bed > ${OUTDIR}/rRNA_intervals_merged.bed
