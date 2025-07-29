#!/bin/bash
#FLUX: --job-name=coverage_scaff3
#FLUX: --queue=small
#FLUX: -t=14400
#FLUX: --urgency=16

module load biokit
cd /scratch/project_2001443
BAMPATH=/scratch/project_2001443/bam
file=$(sed -n "$SLURM_ARRAY_TASK_ID"p /scratch/project_2001443/bam/nodupl_RG_clip/pierre.list)
samtools flagstat -@4 $BAMPATH/nodupl_RG_clip/$file > $BAMPATH/stats/map_stats/$file"_nodupl.flagstat"
/scratch/project_2001443/bam/pierre_flagstat.sh
module load biokit
FINALDIR=/scratch/project_2001443/bam/nodupl_RG
cd /scratch/project_2001443/bam/nodupl
file=$(sed -n "$SLURM_ARRAY_TASK_ID"p nodupl_name.list)
sample=${file%_nodupl*}
java -Xmx4G -jar /appl/soft/bio/picard/picard-tools-2.21.4/picard.jar AddOrReplaceReadGroups \
    I=$file \
    O=$FINALDIR/$sample"_nodupl_wRG.bam" \
    RGID=$sample \
    RGPL=illumina \
    RGLB=1 \
    RGSM=$sample \
    RGPU=1 \
    TMP_DIR=/scratch/project_2001443/tmp
samtools index $FINALDIR/$sample"_nodupl_wRG.bam"
module load bioconda/3
source activate myenv
mosdepth -t 1 -b 10000 -n -x ../stats/coverage/$sample $FINALDIR/$sample"_nodupl_wRG.bam"
mosdepth -t 1 -b 10000 -n ../stats/coverage/${sample}_overlap_correction $FINALDIR/$sample"_nodupl_wRG.bam"
module load biokit
BAMDIR=/scratch/project_2001443/bam/nodupl_RG_clip
cd /scratch/project_2001443/bam/nodupl_RG_clip
file=$(sed -n "$SLURM_ARRAY_TASK_ID"p bam.list)
sample=${file%_nodupl*}
module load bioconda/3
source activate my_seqdata
mosdepth -t 1 -b 100000 -c Scaffold03  -n -x ../stats/coverage_scaff03/$sample $BAMDIR/$sample"_nodupl_wRG_clip.bam"
mosdepth -t 1 -b 100000 -c Scaffold03 -n ../stats/coverage_scaff03/${sample}_overlap_correction $BAMDIR/$sample"_nodupl_wRG_clip.bam"
