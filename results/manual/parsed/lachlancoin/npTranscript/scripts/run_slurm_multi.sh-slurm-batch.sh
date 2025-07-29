#!/bin/bash
#SBATCH --job-name=corona2_analysis
#SBATCH --output=corona_%A_%a.out
#SBATCH --error=corona_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=9000
#SBATCH --time=4-04:00:00
#SBATCH --constraint=ntasks-per-node=1

export JSA_MEM='8000m'

export JSA_MEM=8000m
npTranscript=${HOME}/github/npTranscript
bamdir="."
if [ -f todo.txt ]; then
	n=$SLURM_ARRAY_TASK_ID
	bamfiles=$(cat todo.txt | tail -n +$n | head -n 1)
	blen=$(echo ${bamfiles} | grep '.bam$' | wc -l)
	if [ $blen -eq 0 ]; then
		bamdir=$bamfiles
	        bamfiles=$(ls ${bamdir} | grep '.bam$' | xargs -I {} echo ${bamdir}/{})
	else
		bamdir=$(echo ${bamfiles} | rev | cut -f 2- -d / | rev)
	fi
else
	bamfiles=$(ls ${bamdir} | grep '.bam$' | xargs -I {} echo ${bamdir}/{})
fi
echo " bam dir ${bamdir}" 
bamfiles1=$(echo $bamfiles | sed 's/ /:/g')
echo $bamfiles1
opts1="" 
a=$(ls  | grep '^reads_in.txt$'  | wc -l)
if [ $a -eq 1 ]; then 
  opts1="--readList reads_in.txt" 
fi
reference="${npTranscript}/data/SARS-Cov2/VIC01/wuhan_coronavirus_australia.fasta.gz"
coord_file="${npTranscript}/data/SARS-Cov2/VIC01/Coordinates.csv"
dat=$(date +%Y%m%d%H%M)
resdir="${bamdir}/results_${dat}"
echo $resdir
echo $bamfiles1 > "${resdir}/types.txt" 
opts="--bin 10 --breakThresh 1000"
bash ${npTranscript}/scripts/run.sh --bamFile=${bamfiles1}   --reference=${reference} --annotation ${coord_file} --resdir ${resdir} ${opts} ${opts1}
cd ${resdir}
Rscript ~/github/npTranscript/R/npTranscript.R
