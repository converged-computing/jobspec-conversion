#!/bin/bash
#SBATCH --job-name=sra_tools
#SBATCH --output=Array_test.%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --array=1-101

ml sra-tools/3.0.0
sra_numbers=($(echo {1016570..1016671}))
sra_id='ERR'${sra_numbers[ $SLURM_ARRAY_TASK_ID - 1 ]}
prefetch --max-size 100G $sra_id --force yes --verify no
fastq-dump --outdir . --gzip --skip-technical  --readids --read-filter pass --dumpbase --split-3 --clip ${sra_id}/${sra_id}.sra
