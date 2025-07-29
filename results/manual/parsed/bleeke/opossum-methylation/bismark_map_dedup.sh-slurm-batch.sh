#!/bin/bash
#SBATCH --job-name=bsseq_op
#SBATCH --output=BSseq_oposs_embryos_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=80G
#SBATCH --time=3-00:00:00
#SBATCH --partition=cpu
#SBATCH --array=1-200

echo "begin"
date
LIBNUM=$(sed -n "${SLURM_ARRAY_TASK_ID}p" to_map_please.txt)
echo "we are working on library number" "$LIBNUM"
TRIMDIR=/camp/lab/turnerj/working/Bryony/BSseq/opossum_embryos/data/trimmed # files generated previously, see commented-out sections "merge" and "trim" below
BAMDIR=/camp/lab/turnerj/working/Bryony/manuscript/analysis/data/bams
DEDUPDIR=/camp/lab/turnerj/working/Bryony/manuscript/analysis/data/bams/deduplicated
GENOMEDIR=/camp/lab/turnerj/working/Bryony/manuscript/analysis/annotations/genome # opossum genome, inc pseudoY and gap-filled Xchr at RSX locus
EXTRACTDIR=/camp/lab/turnerj/working/Bryony/manuscript/analysis/data/methyl_extract
TEMPDIR=/camp/lab/turnerj/scratch/bryony
cd $TRIMDIR
ml purge
module use -a /camp/apps/eb/dev/modules/all
ml Bismark
echo "using Bismark version" 
which Bismark
bismark --non_directional --un --ambiguous --temp_dir $TEMPDIR -output_dir $BAMDIR --genome $GENOMEDIR LEE307A${LIBNUM}_*.fq.gz   
cd $BAMDIR
deduplicate_bismark --output_dir $DEDUPDIR --bam LEE307A${LIBNUM}_*.bam
echo "end"
date
