#!/bin/bash
#FLUX: --job-name=RS-03684232_methyl_extract
#FLUX: --queue=general-compute --qos=general-compute
#FLUX: -t=43200
#FLUX: --priority=16

module load gcc
module load samtools
conda init bash
conda activate bismark
cd $PBS_O_WORKDIR 
bismark_methylation_extractor \
--bedGraph /projects/rpci/joyceohm/pnfioric/RRBS_samfile_links/RS-03684232_001_val_1.fq_trimmed_bismark_bt2_pe.sam \
-o /panasas/scratch/grp-joyceohm/rrbs_methyl_extract/methyl_extract_RS-03684232
