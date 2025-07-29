#!/bin/bash
#SBATCH --mail-user=samgould@mit.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --qos=low
#SBATCH --array=1-48
#SBATCH --exclude=c[5-22]

cd /net/bmc-lab2/data/lab/sanchezrivera/samgould/
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/config_fastq_join.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
/net/bmc-lab2/data/lab/sanchezrivera/samgould/fastq-join/fastq-join ./230801San/trimmed_fastq_files_100nt/${R1_FILE} ./230801San/trimmed_fastq_files_100nt/${R2_FILE} -o ./230801San/fastq-join/${folder_name}_%.fastq
