#!/bin/bash
#FLUX: --job-name=arid-parsnip-3709
#FLUX: --urgency=15

module load miniconda3/v4
source /home/software/conda/miniconda3/bin/condainit
conda activate /home/samgould/.conda/envs/sensor_lib_sg
cd /net/bmc-lab2/data/lab/sanchezrivera/samgould/
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/config_processing_joined_reads.txt
joined_file=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
F_HANDLE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
R_HANDLE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
python3 joined_read_analyzer.py ./230801San/fastq-join/${joined_file} ${F_HANDLE} ${R_HANDLE}
