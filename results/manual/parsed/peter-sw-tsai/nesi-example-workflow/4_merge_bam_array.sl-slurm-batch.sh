#!/bin/bash
#SBATCH --job-name=mergeBams
#SBATCH --account=xxxxxxxx
#SBATCH --output=logs/merge/merge_%a.out
#SBATCH --error=logs/merge/merge_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=04:00:00

module load SAMtools/1.19-GCC-12.3.0
OUTDIR=merged_bam
mkdir -p $OUTDIR
FILES=($(ls -1 sample_list/*.txt))
BAMLIST=${FILES[$SLURM_ARRAY_TASK_ID]}
OUTBAM=`basename ${BAMLIST%.txt}.bam`
samtools merge -@ $SLURM_CPUS_PER_TASK -b $BAMLIST -o $OUTDIR/$OUTBAM
