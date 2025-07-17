#!/bin/bash
#FLUX: --job-name=abra
#FLUX: -n=12
#FLUX: --queue=defq
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
source /home/lw74/.bashrc
source /home/lw74/.bash_profile
conda activate abra_env
module load samtools
module load java
refGenome="/work/lw74/refGenome/Pbar.2022.LG.fa"
threads=4
outdir="/work/lw74/habro/mapped_filtered_realigned_bams"
mkdir -p "/work/lw74/habro/mapped_filtered_realigned_bams"
bamdir="/work/lw74/habro/mapped_filtered_bams"
flist=$(ls $bamdir/*mapped_filtered.bam)
flist=(${flist[@]})
bfile="${flist[$SLURM_ARRAY_TASK_ID]}"
logname="$(basename $bfile | sed 's/_mapped_filtered.bam/.abra.realign.log/g')"
rfname="$(basename $bfile | sed 's/.bam/.realigned.bam/g')"
abra2 --in $bfile --out $outdir/$rfname --ref $refGenome --threads $threads --tmpdir . > $logname
samtools index $outdir/$rfname $outdir/$rfname".bai"
