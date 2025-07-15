#!/bin/bash
#FLUX: --job-name=red-general-6962
#FLUX: --urgency=16

module load gcc/9.2.0 bcftools/1.14 conda3 plink2/2.0
ukbbdir=/n/groups/marks/databases/ukbiobank/ukbb_450k
bash make_data.sh ../data/temp \
                    ../data/data \
                    ../gene_list.txt \
                    $ukbbdir/pop_vcf \
                    $ukbbdir/vep \
                    ../figures/init_data_plots
