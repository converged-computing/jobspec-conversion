#!/bin/bash
#FLUX: --job-name=preseq
#FLUX: -c=6
#FLUX: --queue=bigmem
#FLUX: --urgency=16

module purge
module load preseq/3.2.0
module load BEDTools/2.30.0-GCC-10.2.0
BAMDIR=$1
PRESEQDIR=$2
mkdir ${PRESEQDIR}/BEDFiles
BAMFILES=($(ls -1 $BAMDIR/*.dedup.filtered.bam))
i=$(($SLURM_ARRAY_TASK_ID - 1))
THISBAMFILE=${BAMFILES[i]}
name=$(basename ${THISBAMFILE})
bedtools bamtobed -i $THISBAMFILE > ${PRESEQDIR}/BEDFiles/${name}.bed
/soft/system/software/preseq/3.2.0/preseq lc_extrap -o ${PRESEQDIR}/${name}_lc_extrap.txt ${PRESEQDIR}/BEDFiles/${name}.bed # predict the complexity curve of a sequencing library
