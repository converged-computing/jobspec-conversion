#!/bin/bash
#FLUX: --job-name=doopy-chip-4100
#FLUX: --queue=exacloud
#FLUX: -t=1440
#FLUX: --urgency=16

PROJECT=/your/project/directory/
source $PROJECT/cutAnd_seacr/cutAndConfig.sh
IN=$PROJECT/process/beds
IN2=$PROJECT/process/bams
OUT=$PROJECT/process/seacr
TODO=$PROJECT/cutAnd_seacr/$todo
mkdir -p $OUT
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
currINFO=`awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}' $TODO`
NAME=${currINFO%%.bam}
DATA=$NAME.ds.bedgraph
if [[ "$DATA" == *1_* ]]; then
	REF1=$NAME.relaxed.bed
	REF2=`echo $REF1 | sed 's/1_/2_/'`
	BASE=`echo $NAME | sed 's/1_/_/'`
fi
cmd="$BEDTOOLS intersect -a $OUT/$REF1 -b $OUT/$REF2 -wa | cut -f1-3 | sort | uniq > $OUT/$BASE\_Ref1_merge.bed"
echo "Merge -wa"
echo $cmd
eval $cmd
cmd="$BEDTOOLS intersect -a $OUT/$REF1 -b $OUT/$REF2 -wb | cut -f1-3 | sort | uniq > $OUT/$BASE\_Ref2_merge.bed"	
echo "Merge -wb"
echo $cmd
eval $cmd
echo "Replicate merge total:"
cmd="cat $OUT/*$MARK\_*_merge.bed | sort -k1,1 -k2,2n | $BEDTOOLS merge | tee $OUT/$MARK\_merge.bed | wc -l"
echo $cmd
eval $cmd
