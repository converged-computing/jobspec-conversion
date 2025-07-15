#!/bin/bash
#FLUX: --job-name=adorable-platanos-5305
#FLUX: --urgency=16

java -Xmx16G -jar /projects1/tools/multivcfanalyzer/0.0.87/MultiVCFanalyzer_0-87.jar \
NA \
/projects1/microbiome_sciences/reference_genomes/Pseudopropionibacterium_propionicum/Pseudopropionibacterium_propionicum_F0230a.fa \
NA \
/projects1/microbiome_calculus/pacific_calculus/04-Analysis/phylogenies/pseudopropionibacterium_propionicum/multivcfanalyzer_hom/ \
T \
30 \
5 \
0.9 \
0.9 \
NA \
/projects1/microbiome_calculus/pacific_calculus/04-Analysis/phylogenies/pseudopropionibacterium_propionicum/genotyping/*/*.vcf.gz
