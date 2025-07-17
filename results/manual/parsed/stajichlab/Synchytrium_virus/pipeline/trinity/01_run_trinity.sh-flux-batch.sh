#!/bin/bash
#FLUX: --job-name=crusty-cherry-7395
#FLUX: -n=32
#FLUX: --queue=intel
#FLUX: --urgency=16

module load trinity-rnaseq/2.13.2
MEM=256G
N=${SLURM_ARRAY_TASK_ID}
if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "need to provide a number by --array or cmdline"
        exit
    fi
fi
CPU=1
if [ ! -z $SLURM_CPUS_ON_NODE ]; then
    CPU=$SLURM_CPUS_ON_NODE
fi
INDIR=input
OUTDIR=assembly
SAMPLE=$(ls $INDIR | sed -n ${N}p)
LEFT=$(ls -1 $INDIR/$SAMPLE/*_1.fastq.gz | perl -p -e 's/\s+/,/g;' | perl -p -e 's/,$//')
RIGHT=$(echo -n "$LEFT" | perl -p -e 's/_1\.fastq/_2.fastq/g')
OUT=$OUTDIR/trinity_$SAMPLE
mkdir -p $OUT
	Trinity --seqType fq --max_memory $MEM --left $LEFT --right $RIGHT --CPU $CPU --trimmomatic --output $OUT
