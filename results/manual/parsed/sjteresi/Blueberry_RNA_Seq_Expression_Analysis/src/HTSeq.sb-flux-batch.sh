#!/bin/bash
#FLUX: --job-name=HTSeq
#FLUX: -c=2
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load Anaconda2/4.2.0
source activate HTSeq
begin=`date +%s`
echo $HOSTNAME
echo "My Task ID:" $SLURM_ARRAY_TASK_ID
mapping_location='/mnt/research/edgerpat_lab/Scotty/Blueberry_RNA_Seq_Expression_Analysis/results/star_map/'
cd $mapping_location
Read_Folder_Path=$(ls -d $PWD/* | sed -n ${SLURM_ARRAY_TASK_ID}p)
Read_Base=`basename $Read_Folder_Path` 
cd /mnt/research/edgerpat_lab/Scotty/Blueberry_RNA_Seq_Expression_Analysis/results/htseq/
htseq-count --format=sam --order=name --stranded=yes --type=exon --idattr=Parent --mode=union ${Read_Folder_Path}/SortedSam.sam /mnt/research/edgerpat_lab/Scotty/Blueberry_RNA_Seq_Expression_Analysis/data/V_corymbosum_v1.0_geneModels.gff > ${Read_Base}_Results.count
gzip ${Read_Folder_Path}/SortedSam.sam
end=`date +%s`
elapsed=`expr $end - $begin`
echo Time taken: $elapsed
