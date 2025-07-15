#!/bin/bash
#FLUX: --job-name=scruptious-omelette-8307
#FLUX: --priority=16

module load miniconda3/v4
source /home/software/conda/miniconda3/bin/condainit
conda activate /home/samgould/.conda/envs/sensor_lib_sg
cd /net/bmc-lab2/data/lab/sanchezrivera/samgould
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/sensor_extraction_config.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
python3 sensor_extraction.py p53_library_WITH_DUPLICATES_with_handles.csv unique_protos.npy ${R1_FILE} ${R2_FILE} -o ${folder_name}
