#!/bin/bash
#FLUX: --job-name=mask
#FLUX: --queue=nocona
#FLUX: --priority=16

module load gcc/10.1.0 bedtools2/2.29.2
RMPATH=/lustre/work/daray/software/RepeatMasker-4.1.0/util
NAMESFILE=/lustre/scratch/aosmansk/new_croc_assemblies/repeatmasker/RM_LIST
CHRANGE=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)
GENOME=${CHRANGE}_ref-based_assembly
BASEDIR=/lustre/scratch/aosmansk/new_croc_assemblies/repeatmasker
RMOUT=${GENOME}.fa.out.new
WORKDIR=/lustre/scratch/aosmansk/new_croc_assemblies/repeatmasker/${CHRANGE}"_RM"
cd $WORKDIR
mkdir $WORKDIR/rmout2gff
DIR=$WORKDIR/rmout2gff
awk '{print $5}' $WORKDIR/$RMOUT | uniq | sed -e '1,3d' > $DIR/QUERIES.txt
cd $DIR
echo "##gff-version 3" >> ${CHRANGE}.gff
for line in $(cat $DIR/QUERIES.txt); do \
        awk -v var="$line" '$5==var' $WORKDIR/$RMOUT > $line.rmout; \
        min=1; \
        max=$(awk 'NR==1{max = $7 + 0; next} {if ($7 > max) max = $7;} END {print max}' $line.rmout); \
        echo "##sequence-region" $line $min $max >> ${CHRANGE}.gff; \
        awk '{printf $5"\t""RepeatMasker""\t""dispersed_repeat""\t"$6"\t"$7"\t"$1"\t";if ($9 =="C") print "-""\t"".""\t""Target="$10,$14,$13; else print "+""\t"".""\t""Target="$10,$12,$13}' $line.rmout >> ${CHRANGE}.gff; \
        rm $line.rmout; \
done
