#!/bin/bash
#FLUX: --job-name=crusty-squidward-3662
#FLUX: -n=16
#FLUX: --priority=16

module load subread
BAMDIR=/gpfs/group/pipkin/hdiao/Exp337/1_bowtie2
OUTDIR=/gpfs/group/pipkin/hdiao/Exp337/2_featureCounts
ref_gff=/gpfs/group/pipkin/hdiao/Exp337/codes_hpc/Mus_musculus.GRCm38.102.mRNA.simp.rmdup.srt.gff3
bam_pos=$BAMDIR/337_${SLURM_ARRAY_TASK_ID}_srt_flt_pos_srt.bam
bam_neg=$BAMDIR/337_${SLURM_ARRAY_TASK_ID}_srt_flt_neg_srt.bam
pos_mRNA_count=$OUTDIR/337_${SLURM_ARRAY_TASK_ID}_pos_mRNA.txt
neg_mRNA_count=$OUTDIR/337_${SLURM_ARRAY_TASK_ID}_neg_mRNA.txt
featureCounts -T 16 -t "mRNA" -f -O -g ID -p -B -C -a $ref_gff -o $pos_mRNA_count $bam_pos
featureCounts -T 16 -t "mRNA" -f -O -g ID -p -B -C -a $ref_gff -o $neg_mRNA_count $bam_neg
