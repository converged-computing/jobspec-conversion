#!/bin/bash
#FLUX: --job-name=HISATmap
#FLUX: -n=4
#FLUX: --queue=cpu
#FLUX: -t=259200
#FLUX: --priority=16

echo "start"
date
TRIMDIR=/camp/lab/turnerj/working/Bryony/opossum_adult/rna-seq/data/newmap/trimmed
BAMDIR=/camp/lab/turnerj/working/Bryony/opossum_adult/allele-specific/data/rna-seq/bams
GENOMEDIR=/camp/lab/turnerj/working/shared_projects/OOPs/genome/n-masked/mondom5_pseudoY_X-gaps-filled_220819_JZ_masked # modified and n-masked genome made by jasmin 20190927
cd $TRIMDIR
FILE1=$(sed -n "${SLURM_ARRAY_TASK_ID}p" trimmed.txt)
FILE2="${FILE1/R1*val_1.fq.gz/}R2*val_2.fq.gz"
OUTFILE="${FILE1/R1*val_1.fq.gz/}.sam"
echo "we will map" $FILE1 $FILE2 
ml purge
ml HISAT2
echo "modules loaded are:" 
ml
cd $BAMDIR
hisat2 --no-softclip --no-mixed --no-discordant -x $GENOMEDIR -1 $FILE1 -2 $FILE2 -S $OUTFILE
date 
echo "end"
