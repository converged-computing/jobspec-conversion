#!/bin/bash
#FLUX: --job-name=glrna_cd
#FLUX: --queue=girirajan
#FLUX: -t=1440000
#FLUX: --urgency=16

echo `date` starting job on $HOSTNAME
cache_dir="/data6/deepro/rna_cache" # TODO: set project dir path
glrna_image="/data6/deepro/rna_cache/glrna-amd64_latest.sif" # TODO: set glrna pulled image path
singularity exec --containall -H $cache_dir:/data -B $cache_dir:/data $glrna_image python3 /rnacounts/counts_to_de.py --treatment_names hcc1395_tumor_rep1_r1Aligned hcc1395_tumor_rep2_r1Aligned hcc1395_tumor_rep3_r1Aligned --control_names hcc1395_normal_rep1_r1Aligned hcc1395_normal_rep2_r1Aligned hcc1395_normal_rep3_r1Aligned 
echo `date` ending job on $HOSTNAME
