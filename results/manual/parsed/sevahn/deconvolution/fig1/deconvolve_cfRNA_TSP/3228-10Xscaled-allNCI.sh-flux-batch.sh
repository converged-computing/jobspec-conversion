#!/bin/bash
#FLUX: --job-name=decon3228-10Xscaled-allNCI
#FLUX: --queue=quake,normal
#FLUX: -t=18000
#FLUX: --urgency=16

source activate snakemake
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['3228'] , 'NNLS', '3228',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['3228'] , 'QP', '3228',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1,  '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['3228'] , 'nuSVR', '3228',  jackknife = False)"
