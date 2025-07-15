#!/bin/bash
#FLUX: --job-name=moolicious-frito-7390
#FLUX: -c=20
#FLUX: --urgency=16

module purge
module load BEDTools/2.30.0-GCC-10.2.0
module load SAMtools/1.12-GCC-10.2.0
BAMDIR=$1
BIGWIGDIR=$2
FUNCTIONDIR=$3
chrom_sizes=$4
BAMFILES=($(ls -1 $BAMDIR/*dedup.filtered.bam))
i=$(($SLURM_ARRAY_TASK_ID - 1))
THISBAMFILE=${BAMFILES[i]}
name=$(basename ${THISBAMFILE} .bam)
bedtools genomecov -ibam $THISBAMFILE -bg -scale 1 > ${BIGWIGDIR}/${name}.bedgraph #scale 1 option: scale our coverage to reads/million instead of the command above, use the scaling option to scale it to the total number of mapped reads in millions replace the 1 in "-scale 1" with however many million reads are in your file
LC_COLLATE=C sort -k1,1 -k2,2n ${BIGWIGDIR}/${name}.bedgraph > ${BIGWIGDIR}/${name}.sorted.bedgraph
${FUNCTIONDIR}/bedGraphToBigWig ${BIGWIGDIR}/${name}.sorted.bedgraph $chrom_sizes ${BIGWIGDIR}/${name}.bw
samtools idxstats ${THISBAMFILE} | awk '{sum+=$3}END{print sum}'
