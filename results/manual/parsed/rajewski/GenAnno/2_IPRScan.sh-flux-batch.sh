#!/bin/bash
#FLUX: --job-name=crunchy-hippo-7922
#FLUX: -n=16
#FLUX: --urgency=16

set -euv
module load interproscan
if [ ! -d "$IPROUT" ]; then
  mkdir ~/bigdata/Csativa/results/2_IPRScan
fi
interproscan.sh \
    -i ~/bigdata/Csativa/results/1_FunannotatePredict/predict_results/purple_kush.proteins.fa.$SLURM_ARRAY_TASK_ID \
    -appl CDD,COILS,Gene3D,HAMAP,MobiDBLite,Pfam,PIRSF,PRINTS,ProDom,PROSITEPATTERNS,PROSITEPROFILES,SFLD,SMART,SUPERFAMILY,TIGRFAM \
    -d ~/bigdata/Csativa/results/2_IPRScan \
    --goterms
