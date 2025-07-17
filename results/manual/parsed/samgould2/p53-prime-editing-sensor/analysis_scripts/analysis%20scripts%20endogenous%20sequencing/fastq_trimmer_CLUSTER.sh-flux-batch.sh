#!/bin/bash
#FLUX: --job-name=gloopy-truffle-2449
#FLUX: --urgency=16

module load miniconda3/v4
source /home/software/conda/miniconda3/bin/condainit
conda activate /home/samgould/.conda/envs/sensor_lib_sg
cd /net/bmc-lab2/data/lab/sanchezrivera/samgould/230801San/
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/config_singular.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
python3 /net/bmc-lab2/data/lab/sanchezrivera/samgould/fastq_trimmer.py ${R1_FILE} ${R2_FILE}
