#!/bin/bash
#FLUX: --job-name=3.3_LK_SB_1p.sh
#FLUX: -n=4
#FLUX: -c=12
#FLUX: --queue=batch
#FLUX: -t=259200
#FLUX: --urgency=16

module load STAR/2.7.10b-GCC-11.3.0
LK_trimmed_fq="/scratch/ahw22099/FireAnt_GRN/LK_trimmed_fq"
if [ ! -d $LK_trimmed_fq ]
then
mkdir -p $LK_trimmed_fq
fi
STAR_genome_SB="/scratch/ahw22099/FireAnt_GRN/STAR_genome_SB"
if [ ! -d $STAR_genome_SB ]
then
mkdir -p $STAR_genome_SB
fi
SB_genome="/scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB"
if [ ! -d $SB_genome ]
then
mkdir -p $SB_genome
fi
LK_STAR_SB="/scratch/ahw22099/FireAnt_GRN/LK_STAR_SB"
if [ ! -d $LK_STAR_SB ]
then
mkdir -p $LK_STAR_SB
fi
FirstPass_SB="/scratch/ahw22099/FireAnt_GRN/LK_STAR_SB/1p_out"
if [ ! -d $FirstPass_SB ]
then
mkdir -p $FirstPass_SB
fi
cd $LK_trimmed_fq
R1_sample_list=($(<LK_trimmed_input_list_1.txt))
R2_sample_list=($(<LK_trimmed_input_list_2.txt))
R1=${R1_sample_list[${SLURM_ARRAY_TASK_ID}]}
R2=${R2_sample_list[${SLURM_ARRAY_TASK_ID}]}
echo $R1
echo $R2
base=`basename "$R1" .R1_val_1.fq.gz`
STAR \
--readFilesCommand zcat \
--runThreadN 8 \
--genomeDir $STAR_genome_SB \
--readFilesIn $R1 $R2 \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNoverLmax 0.05 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--genomeLoad NoSharedMemory \
--outSAMtype BAM SortedByCoordinate \
--outSAMstrandField intronMotif \
--outSAMattrIHstart 0 \
--outFileNamePrefix $FirstPass_SB/"$base".SB1pass. \
--limitBAMsortRAM 30000000000
