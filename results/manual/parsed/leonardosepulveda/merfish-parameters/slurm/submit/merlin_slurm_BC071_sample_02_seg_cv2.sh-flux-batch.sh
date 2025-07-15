#!/bin/bash
#FLUX: --job-name=evasive-hobbit-8517
#FLUX: --urgency=16

date +'Starting at %R.'
source centos7-modules.sh
module load Anaconda3/5.0.1-fasrc01
source activate merlin_env
module load gcc/8.2.0-fasrc01
module load fftw
which python
echo BC071_sample_02
merlin -k snakemake_parameters.json \
       -a merlin_analysis_BC071_seg_cv2.json \
       -o data_organization_BC071_3.csv \
       -p positions_BC071_sample_02.txt \
       -c C1E1_codebook.csv \
       -m MERFISH3.json \
       -n 1000 \
       191212_BC071_MERFISH/sample_02
date +'Finished at %R.'
