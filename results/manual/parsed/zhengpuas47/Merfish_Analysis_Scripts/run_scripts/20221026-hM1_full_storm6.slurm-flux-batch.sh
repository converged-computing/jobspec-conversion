#!/bin/bash
#FLUX: --job-name=quirky-mango-7012
#FLUX: --priority=16

export PATH='/n/home13/pzheng/anaconda3/bin:$PATH'

date +'Starting at %R.'
. "/n/home13/pzheng/anaconda3/etc/profile.d/conda.sh"
export PATH="/n/home13/pzheng/anaconda3/bin:$PATH"
conda activate merlin_env
merlin -a 20221025-hM1_cellpose.json \
		-o 20221025-hM1_22bits_adaptors.csv \
		-c human_M1_codebook.csv \
		-m storm6_microscope.json \
		-p 20221026_positions.txt \
		-e /n/holyscratch01/zhuang_lab/Users/pzheng/MERFISH_Data \
		-s /n/holyscratch01/zhuang_lab/Users/pzheng/MERFISH_Analysis \
		-k run_hM1_cellpose.json \
		-n 2 \
		--no_report True \
		20221026-hM1_hM1
date +'Finished at %R.'
