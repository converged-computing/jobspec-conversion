#!/bin/bash
#FLUX: --job-name=rainbow-lemur-3741
#FLUX: --urgency=15

module load miniconda3/v4
source /home/software/conda/miniconda3/bin/condainit
conda activate /home/samgould/.conda/envs/crispresso_env
cd /net/bmc-lab2/data/lab/sanchezrivera/samgould/singular_competition_assay_data_PE_a549
python3 crispresso_analysis_rerun.py full_sample_amplicon_info.csv #${folder_name}
