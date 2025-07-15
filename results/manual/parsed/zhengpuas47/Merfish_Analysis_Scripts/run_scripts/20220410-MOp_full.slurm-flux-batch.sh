#!/bin/bash
#FLUX: --job-name=conspicuous-lemon-1813
#FLUX: --urgency=16

export PATH='/n/home13/pzheng/anaconda3/bin:$PATH'

date +'Starting at %R.'
. "/n/home13/pzheng/anaconda3/etc/profile.d/conda.sh"
export PATH="/n/home13/pzheng/anaconda3/bin:$PATH"
conda activate merlin_env
merlin -a 20220312-MOp_cellpose.json \
		-o 20220328-M1_22bits_adaptors.csv \
		-c M1_codebook.csv \
		-m storm6_microscope.json \
		-p 20220410_positions.txt \
		-e /n/holyscratch01/zhuang_lab/Users/pzheng/MERFISH_Data \
		-s /n/holyscratch01/zhuang_lab/Users/pzheng/Analysis_results \
		-k run_M1_cellpose.json \
		-n 2 \
		--no_report True \
		20220410-M1_renamed
date +'Finished at %R.'
