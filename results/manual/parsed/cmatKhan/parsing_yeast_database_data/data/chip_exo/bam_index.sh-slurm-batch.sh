#!/bin/bash
#SBATCH --job-name=bam_index
#SBATCH --output=bam_index.out
#SBATCH --error=bam_index.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1

eval $(spack load --sh samtools@1.13)
lookup="$1"
BAM_FILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $lookup)
samtools index $BAM_FILE
echo "BAM file $BAM_FILE indexed successfully."
