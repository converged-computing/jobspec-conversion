#!/bin/bash
#FLUX: --job-name=mergeBams
#FLUX: -c=8
#FLUX: -t=14400
#FLUX: --priority=16

module load SAMtools/1.19-GCC-12.3.0
OUTDIR=merged_bam
mkdir -p $OUTDIR
FILES=($(ls -1 sample_list/*.txt))
BAMLIST=${FILES[$SLURM_ARRAY_TASK_ID]}
OUTBAM=`basename ${BAMLIST%.txt}.bam`
samtools merge -@ $SLURM_CPUS_PER_TASK -b $BAMLIST -o $OUTDIR/$OUTBAM
