#!/bin/bash
#FLUX: --job-name=decon1950-10Xscaled-allNCI
#FLUX: --queue=quake,normal
#FLUX: -t=18000
#FLUX: --urgency=16

source activate snakemake
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['1950'] , 'NNLS', '1950',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['1950'] , 'QP', '1950',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1,  '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['1950'] , 'nuSVR', '1950',  jackknife = False)"
