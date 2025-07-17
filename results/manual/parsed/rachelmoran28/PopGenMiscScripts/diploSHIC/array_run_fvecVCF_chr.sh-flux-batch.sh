#!/bin/bash
#FLUX: --job-name=fvecVCF
#FLUX: --queue=small,amdsmall
#FLUX: -t=7200
#FLUX: --urgency=16

source /home/mcgaughs/rmoran/miniconda3/etc/profile.d/conda.sh
conda activate diplo
cd /home/mcgaughs/shared/Software/diploSHIC
vcf="/home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/filtered_snps/HardFilteredSNPs_250Samples"
Pop="Tinaja"
CMD_LIST="HardFiltered_All_Commands_fvecVCF.txt"
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
