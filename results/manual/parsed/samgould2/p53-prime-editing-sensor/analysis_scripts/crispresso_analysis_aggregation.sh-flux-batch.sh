#!/bin/bash
#FLUX: --job-name=spicy-cat-0042
#FLUX: --urgency=15

module load miniconda3/v4
source /home/software/conda/miniconda3/bin/condainit
conda activate /home/samgould/.conda/envs/crispresso_env
cd /net/bmc-lab2/data/lab/sanchezrivera/samgould
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/sensor_extraction_config.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
python3 crispresso_analysis_aggregation.py p53_crispresso_quant.csv ${folder_name} crispresso_quant_blank.csv
