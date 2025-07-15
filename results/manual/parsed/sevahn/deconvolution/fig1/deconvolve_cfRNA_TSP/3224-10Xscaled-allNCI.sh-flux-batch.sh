#!/bin/bash
#FLUX: --job-name=decon3224-10Xscaled-allNCI
#FLUX: --queue=quake,normal
#FLUX: -t=18000
#FLUX: --priority=16

source activate snakemake
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['3224'] , 'NNLS', '3224',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['3224'] , 'QP', '3224',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1,  '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['3224'] , 'nuSVR', '3224',  jackknife = False)"
