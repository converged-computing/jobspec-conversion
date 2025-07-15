#!/bin/bash
#FLUX: --job-name=rainbow-milkshake-6295
#FLUX: --urgency=15

cd /net/bmc-lab2/data/lab/sanchezrivera/samgould/
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/singular_competition_assay_data_PE_a549/config_join.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
/net/bmc-lab2/data/lab/sanchezrivera/samgould/fastq-join/fastq-join ./singular_competition_assay_data_PE_a549/230816San/trimmed_fastq_files_100nt/${R1_FILE} ./singular_competition_assay_data_PE_a549/230816San/trimmed_fastq_files_100nt/${R2_FILE} -o ./singular_competition_assay_data_PE_a549/fastq_joined/${folder_name}_%.fastq
