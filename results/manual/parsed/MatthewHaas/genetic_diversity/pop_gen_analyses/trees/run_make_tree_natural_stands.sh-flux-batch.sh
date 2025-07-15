#!/bin/bash
#FLUX: --job-name=buttery-avocado-7097
#FLUX: -n=32
#FLUX: -t=86400
#FLUX: --urgency=16

cd /home/jkimball/haasx092/main_GBS/210309_samtools
module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1
module load R/3.6.0
Rscript make_tree_natural_stands.R natural_stands.recode.vcf natural_stand_samples.csv natural_stand_tree.Rdata natural_stand_tree.pdf
