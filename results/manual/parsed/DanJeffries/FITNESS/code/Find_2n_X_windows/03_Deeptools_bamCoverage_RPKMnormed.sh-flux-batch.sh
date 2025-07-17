#!/bin/bash
#FLUX: --job-name=Ga_DEEP_500
#FLUX: -c=8
#FLUX: --queue=bdw
#FLUX: -t=43200
#FLUX: --urgency=16

module load vital-it
module add UHTS/Analysis/deepTools/2.5.4;
ID=$SLURM_ARRAY_TASK_ID
WD=/storage/scratch/iee/dj20y461/Stickleback/G_aculeatus/FITNESS/Find_2n_X_windows
ITERFILE=/storage/homefs/dj20y461/Stickleback/G_aculeatus/FITNESS/code/Find_2n_X_windows/samples_new.txt
SAMPLE_NAME=$(sed -n "${SLURM_ARRAY_TASK_ID}p" < $ITERFILE)
BAMDIR=$WD/bams
BAM=${BAMDIR}/${SAMPLE_NAME}.fixmate.coordsorted.bam
OUTDIR=$WD/depths
if [ ! -d "$OUTDIR" ]; then
  mkdir $OUTDIR
fi
bamCoverage --bam $BAM \
            --binSize 500 \
            --numberOfProcessors 16 \
            --verbose \
	    --normalizeUsingRPKM \
            --outFileName ${OUTDIR}/${SAMPLE_NAME}.500bp.RPKM.depth \
            --outFileFormat bedgraph
