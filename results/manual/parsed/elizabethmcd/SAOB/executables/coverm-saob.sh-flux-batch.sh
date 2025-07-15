#!/bin/bash
#FLUX: --job-name=coverm-saob
#FLUX: -c=8
#FLUX: -t=43200
#FLUX: --priority=16

project_path="/project/6049207/AD_metagenome-Elizabeth"
mapping_path="/home/eamcdani/scratch/mappingResults"
ref_path="${project_path}/re_binning/np_binning_v2_poly/final_bins_analysis/all_SAOB_bins.fasta"
out_path="/home/eamcdani/scratch"
module load rust samtools
/home/eamcdani/.cargo/bin/coverm genome -s "~" -m relative_abundance --bam-files ${mapping_path}/*.sorted.bam --min-read-aligned-percent 0.75 --min-read-percent-identity 0.95 --min-covered-fraction 0 -x fasta -t 8 &> ${out_path}/saob_relative_abundance.txt
