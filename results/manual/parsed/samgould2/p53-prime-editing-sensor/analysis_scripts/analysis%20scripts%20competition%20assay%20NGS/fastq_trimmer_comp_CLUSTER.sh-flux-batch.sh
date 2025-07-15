#!/bin/bash
#FLUX: --job-name=hanky-soup-4516
#FLUX: --priority=15

module load miniconda3/v4
source /home/software/conda/miniconda3/bin/condainit
conda activate /home/samgould/.conda/envs/sensor_lib_sg
cd /net/bmc-lab2/data/lab/sanchezrivera/samgould/singular_competition_assay_data_PE_a549/230816San/
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/singular_competition_assay_data_PE_a549/config_trim.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
python3 /net/bmc-lab2/data/lab/sanchezrivera/samgould/fastq_trimmer.py ${R1_FILE} ${R2_FILE}
