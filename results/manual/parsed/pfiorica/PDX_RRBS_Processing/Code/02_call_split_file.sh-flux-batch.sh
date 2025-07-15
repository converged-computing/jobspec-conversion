#!/bin/bash
#FLUX: --job-name=split_M_plot_filest
#FLUX: --queue=general-compute
#FLUX: -t=43200
#FLUX: --urgency=16

module load gcc
module load python
cd /projects/rpci/joyceohm/pnfioric/PDX_RRBS_Processing/Code
for sample in `cat /projects/rpci/joyceohm/pnfioric/list_of_RRBS_IDs.txt`; do
	python 02_split_M_file.py --input_duplicated /panasas/scratch/grp-joyceohm/rrbs_methyl_extract/methyl_extract_${sample}/${sample}_001_val_1.fq_trimmed_bismark_bt2_pe.M-bias.txt \
		--input_deduplicated /projects/rpci/joyceohm/pnfioric/RRBS_paths/${sample}/${sample}_nudup.sam.resorted.dedup.M-bias.txt \
		--output /projects/rpci/joyceohm/pnfioric/split_M_files/ \
		--sample ${sample}
done
