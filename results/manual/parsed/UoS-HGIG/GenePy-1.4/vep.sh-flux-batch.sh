#!/bin/bash
#FLUX: --job-name=bumfuzzled-bike-4329
#FLUX: -t=72000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load ensembl-vep
grep -w "chr${SLURM_ARRAY_TASK_ID}" $1 > vcf_chr${SLURM_ARRAY_TASK_ID};
cat vcf_header vcf_chr${SLURM_ARRAY_TASK_ID} > vcf_to_anno_chr${SLURM_ARRAY_TASK_ID}.vcf;
rm vcf_chr${SLURM_ARRAY_TASK_ID}
vep -i vcf_to_anno_chr${SLURM_ARRAY_TASK_ID}.vcf --cache --force_overwrite --pick_allele \
 --custom /mainfs/hgig/private/software/gnomAD/GRCh38/gnomad.exomes.r2.1.1.sites.liftover_grch38.vcf.bgz,gnomadE,vcf,exact,,AF \
 --plugin CADD,/mainfs/hgig/private/software/CADD_V1.6/CADD-scripts/data/annotations/GRCh38_v1.6/no_anno/whole_genome_SNVs.tsv.gz,/mainfs/hgig/private/software/CADD_V1.6/CADD-scripts/data/annotations/GRCh38_v1.6/no_anno/gnomad.genomes.r3.0.indel.tsv \
 --vcf  --fields "Allele,Consequence,SYMBOL,Gene,gnomadE_AF,CADD_RAW" -o ANNO_CHR${SLURM_ARRAY_TASK_ID}.vcf --offline
