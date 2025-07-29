#!/bin/bash
#SBATCH --job-name=snps_call_md
#SBATCH --output=%x-%A-%a.out
#SBATCH --mail-user=me@work
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=09:50:00
#SBATCH --partition=all
#SBATCH --array=1-39

module load vital-it/7
module load UHTS/Analysis/picard-tools/2.18.11
module load UHTS/Analysis/GenomeAnalysisTK/4.1.3.0
infiles=$HOME/Style/step02_AxEx/files_AxEx.txt
filebase=$(cat $infiles | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
TMPDIR=$filebase"/tmp"
file="$HOME/Style/step02_AxEx/Pax_genome/splitCigar_md/"$filebase"/Aligned.sortedByCoord.md.sp.bam"
mkdir -p $TMPDIR
picard-tools AddOrReplaceReadGroups \
             I=$file \
             O=$filebase"/Aligned.sortedByCoord.md.sp_RG.bam" \
             RGSM=$filebase \
	     RGID=$filebase \
	     RGLB=laneX \
             RGPL=illumina \
             RGPU=barcodeX \
	     CREATE_INDEX=true \
             VALIDATION_STRINGENCY=SILENT \
             TMP_DIR=$TMPDIR
GenomeAnalysisTK HaplotypeCaller \
		 -I $filebase"/Aligned.sortedByCoord.md.sp_RG.bam" \
		 --sample-name $filebase \
 		 -O $filebase"/Variants_md.g.vcf.gz" \
		 -R $HOME/Style/Pax_genome/Petunia_axillaris_304.fa \
		 -ERC GVCF \
		 --dont-use-soft-clipped-bases true \
		 --native-pair-hmm-threads 8 \
		 --tmp-dir $TMPDIR
