#!/bin/bash
#FLUX: --job-name=albedo_baseline_models # The job name.
#FLUX: --priority=16

module load anaconda
python model.py > albedo_df_updated/XGboost_record.txt
