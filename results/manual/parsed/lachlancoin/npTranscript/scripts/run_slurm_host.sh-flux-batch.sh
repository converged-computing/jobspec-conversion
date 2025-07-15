#!/bin/bash
#FLUX: --job-name=npTranscript
#FLUX: -c=8
#FLUX: -t=360000
#FLUX: --priority=16

export JSA_MEM='8000m'

export JSA_MEM=8000m
npTranscript=${HOME}/github/npTranscript
bamdir="."
bamfiles=$(ls ${bamdir} | grep '.bam$' | xargs -I {} echo ${bamdir}/{})
bamfiles1=$(echo $bamfiles | sed 's/ /:/g')
echo $bamfiles1
opts1="" 
a=$(ls  | grep '^reads_in.txt$'  | wc -l)
if [ $a -eq 1 ]; then 
  opts1="--readList reads_in.txt" 
fi
reference="../Chlorocebus_sabaeus.ChlSab1.1.dna.toplevel.fa.gz"
coord_file="../Chlorocebus_sabaeus.ChlSab1.1.99.gff3.gz"
dat=$(date +%Y%m%d%H%M%S)
resdir="results_${dat}"
opts="--bin=50 --breakThresh=100 --coronavirus=false --extra_threshold=500 --msaDepthThresh=50 --doMSA=false"
opts="${opts} --RNA=true"
bash ${npTranscript}/scripts/run.sh --bamFile=${bamfiles1}   --reference=${reference} --annotation ${coord_file} --resdir ${resdir} ${opts} ${opts1}
cd ${resdir}
Rscript ~/github/npTranscript/R/npDE.R  control infected betabinom
