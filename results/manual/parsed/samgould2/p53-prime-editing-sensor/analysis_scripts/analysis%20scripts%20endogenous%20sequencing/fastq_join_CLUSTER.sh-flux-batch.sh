#!/bin/bash
#FLUX: --job-name=frigid-bits-5551
#FLUX: --urgency=15

cd /net/bmc-lab2/data/lab/sanchezrivera/samgould/
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/config_fastq_join.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
/net/bmc-lab2/data/lab/sanchezrivera/samgould/fastq-join/fastq-join ./230801San/trimmed_fastq_files_100nt/${R1_FILE} ./230801San/trimmed_fastq_files_100nt/${R2_FILE} -o ./230801San/fastq-join/${folder_name}_%.fastq
