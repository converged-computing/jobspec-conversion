#!/bin/bash
#SBATCH --job-name=dedup
#SBATCH --output=bismark_dedup_mouse_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60G
#SBATCH --time=3-00:00:00
#SBATCH --array=1-36

echo "begin"
date
BAMDIR=/camp/lab/turnerj/working/Bryony/mouse_adult_xci/allele_specific/data/bs-seq/bams/split_bams
INFILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" 20190902_bams_to_dedup.txt)
ml purge
ml Bismark
echo "modules loaded are:" 
ml
cd $BAMDIR
deduplicate_bismark --bam $INFILE
echo "end"
date
