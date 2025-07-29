#!/bin/bash
#FLUX: --job-name=decon1821cfRNA_deconv
#FLUX: --queue=owners,normal
#FLUX: -t=18000
#FLUX: --urgency=16

source activate snakemake
python3 -c "import deconvolve as deconv; deconv.main(1,  'samples.csv', ['1821'] , 'nuSVR', '1821',  jackknife = False)"
