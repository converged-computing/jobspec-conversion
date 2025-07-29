#!/bin/bash
#FLUX: --job-name=npTranscript
#FLUX: -c=8
#FLUX: -t=360000
#FLUX: --urgency=16

export JSA_MEM='30000m'
export coord_file='$(pwd)"/gencode.v28.annotation.gff3.gz'
export reference='$(pwd)"/GRCh38_full_analysis_set_plus_decoy_hla.fa'

export JSA_MEM=30000m
npTranscript=${HOME}/github/npTranscript
bamdir="."
bamfiles=$(ls ${bamdir} | grep '.bam$'  | grep 'primary' | grep 'sorted' | grep -v 'DNA'  |  xargs -I {} echo ${bamdir}/{})
bamfiles1=$(echo $bamfiles | sed 's/ /:/g')
echo $bamfiles1
opts1="" 
a=$(ls  | grep '^reads_in.txt$'  | wc -l)
if [ $a -eq 1 ]; then 
  opts1="--readList reads_in.txt" 
fi
export coord_file="gencode.v28.annotation.gff3"
export coord_file="/DataOnline/Data/Projects/Human_Direct_RNA_Sequencing/Analysis_Guppy_Data/Alignment_minimap2/gencode.v28.annotation.gff3" 
export coord_file=$(pwd)"/gencode.v28.annotation.gff3.gz"
export reference=$(pwd)"/GRCh38_reference_genome/GRCh38_chromosome_only.fa.gz" 
export reference=$(pwd)"/GRCh38_full_analysis_set_plus_decoy_hla.fa"
dat=$(date +%Y%m%d%H%M%S)
resdir="results_${dat}"
opts="--bin=100 --breakThresh=100 --coronavirus=false --maxThreads=8 --extra_threshold=200 --writePolyA=true --msaDepthThresh=50 --doMSA=false --numExonsMSA=1:2:3:4:5 --msa_source=RNA;cDNA  --GFF_features=ID:description:ID:gene_type:gene_name --useExons=true --span=protein_coding --includeStart=false --isoformDepthThresh 100:100:100:100:1:100"
opts="${opts} --RNA=true"
bash ${npTranscript}/scripts/run.sh --bamFile=${bamfiles1}   --reference=${reference} --annotation ${coord_file} --resdir ${resdir} ${opts} ${opts1}
cd ${resdir}
