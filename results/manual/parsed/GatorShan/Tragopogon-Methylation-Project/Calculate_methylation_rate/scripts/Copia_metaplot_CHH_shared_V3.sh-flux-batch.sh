#!/bin/bash
#FLUX: --job-name=Copia_metaplot_CHH_shared_V3
#FLUX: -t=14400
#FLUX: --urgency=16

date;hostname;pwd
module purge
module load python
MTYPE=CHH
TE_TYPE=Copia
GFF=/blue/soltis/shan158538/Methylation/OutPut/TE_annotation_new/repeat_annotation_combined_Copia.final.gff
for SAMPLE in DES1 S1 S2 S3 S4 S5; do
	echo "Processing sample ${SAMPLE}"
	IN=/orange/soltis/shan158538/Methylation_output/feature_methylation/gene_${MTYPE}_shared/${SAMPLE}
	## Using the new values: 1) number of bins: 20; 2) streamsize; 2000
	TE_metaplot_pe_ss.V4.py \
		-m=${MTYPE} \
		-o=${IN}/${SAMPLE}_${MTYPE}_${TE_TYPE}_new2 \
		${GFF} \
		${IN} \
		${SAMPLE}
done
date
