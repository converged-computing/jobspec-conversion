#!/bin/bash
#FLUX: --job-name=fvecVCF
#FLUX: --queue=ram256g,ram1t,amd2tb,amdlarge,amdsmall,small,astyanax,cavefish
#FLUX: -t=100800
#FLUX: --urgency=16

source /home/mcgaughs/rmoran/miniconda3/etc/profile.d/conda.sh
conda activate diplo
cd /home/mcgaughs/shared/Software/diploSHIC
vcf="/home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/combined_filtered/250_samples"
Pop="CabMoroSurface"
CMD_LIST="HardFiltered_All_wInvar_Commands_fvecVCF_5kb.txt"
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
