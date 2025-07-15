#!/bin/bash
#FLUX: --job-name=decon2549-10Xscaled-allNCI
#FLUX: --queue=quake,normal
#FLUX: -t=18000
#FLUX: --priority=16

source activate snakemake
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['2549'] , 'NNLS', '2549',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['2549'] , 'QP', '2549',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1,  '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['2549'] , 'nuSVR', '2549',  jackknife = False)"
