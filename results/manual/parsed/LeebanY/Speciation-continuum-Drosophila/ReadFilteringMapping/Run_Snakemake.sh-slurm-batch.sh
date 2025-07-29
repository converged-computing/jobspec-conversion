#!/bin/bash
#FLUX: --job-name=speccontin
#FLUX: --queue=long
#FLUX: --urgency=16

pwd; hostname; date
conda activate snakemake_drosophilomics
ref=$(ls *fas)
suffix=".fas";
ref_suf=${ref%$suffix}
bwa-mem2 index -p $ref_suf $ref
sed -i "s/refgenA/$ref_suf/g" Species_Pair_Pipeline.snakefile
mkdir addreadgrp_reads
snakemake -s Species_Pair_Pipeline.snakefile --cluster "sbatch --job-name=snakemake_test --nodes=1 --ntasks=16 --partition=medium --mem=20G" -j 1 --conda-frontend conda --until addreadgrps
mkdir calls
ls *.fastq | cut -d'_' -f1 | uniq | sed 's|^|addreadgrp_reads/|g' | sed 's/$/.bam/g' > bamlist.txt
vcf_output=$(ls *.fastq | cut -d'_' -f1 | uniq | tr '\n' '_' | sed 's/.$//')
samtools faidx $ref
freebayes -f $ref --haplotype-length -1 --no-population-priors \
--hwe-priors-off --use-mapping-quality --ploidy 2 --theta 0.02 --bam-list bamlist.txt > calls/calls.combined.vcf
bgzip -c calls/calls.combined.vcf > calls/calls.combined.vcf.gz
tabix -p vcf calls/calls.combined.vcf.gz
