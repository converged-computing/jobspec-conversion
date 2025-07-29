#!/bin/bash
#SBATCH --job-name=fastp_array
#SBATCH --account=uoa00571
#SBATCH --output=logs/fastp/fastp_%a.out
#SBATCH --error=logs/fastp/fastp_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=6G
#SBATCH --time=01:00:00

module purge
module load fastp/0.23.4-GCC-11.3.0
FILES=($(ls -1 raw/dna/*_R1.fastq.gz))
R1=${FILES[$SLURM_ARRAY_TASK_ID]}
R2=${R1%_R1.fastq.gz}_R2.fastq.gz
mkdir -p trimmedFq/
fastp \
--in1 ${R1} \
--in2 ${R2} \
--out1 trimmedFq/`basename ${R1%.fastq.gz}`.trim.fastq.gz \
--out2 trimmedFq/`basename ${R2%.fastq.gz}`.trim.fastq.gz \
--json trimmedFq/`basename ${R1%_R1_001.fastq.gz}`.json \
--html trimmedFq/`basename ${R1%_R1_001.fastq.gz}`.html \
--thread $SLURM_CPUS_PER_TASK
