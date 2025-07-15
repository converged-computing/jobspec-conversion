#!/bin/bash
#FLUX: --job-name=fat-squidward-1552
#FLUX: --urgency=16

CPU=1
INDIR=annotate
SAMPFILE=samples.csv
IFS=,
N=1
m=$(cat $SAMPFILE | while read NAME PREF
do
 name=$NAME
 if [ ! -d $INDIR/${name}/training ]; then
	 echo $N
 fi
 N=$(expr $N + 1)
done | perl -p -e 's/\n/,/' | perl -p -e 's/,$//')
echo "sbatch --array=$m pipeline/01_train_singularity.sh"
