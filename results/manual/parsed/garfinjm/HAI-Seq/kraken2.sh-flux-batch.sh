#!/bin/bash
#FLUX: --job-name=carnivorous-lamp-0055
#FLUX: -t=28801
#FLUX: --urgency=16

ACCESSION=$1
THREADS=$2
DIR_OUT=$3
KRAKEN_DB=$4
FASTQ9=$5
FASTQ10=$6
KRAKEN_REPORT=$7
CONFIG=$8
if [[ ! -e $DIR_OUT ]]; then
        echo "ERROR: $DIR_OUT not found! Exiting."; exit
fi
if [[ ! -e $FASTQ9 ]]; then
        echo "ERROR: $FASTQ9 not found! Exiting."; exit
fi
if [[ ! -e $FASTQ10 ]]; then
        echo "ERROR: $FASTQ10 not found! Exiting."; exit
fi
workdir=$(realpath $(pwd))
echo "bind "
echo $workdir
echo "kraken db" $KRAKEN_DB
echo "output " $DIR_OUT"/"$ACCESSION".kraken"
echo "report " $KRAKEN_REPORT
echo "fastqs " $FASTQ9 $FASTQ10
echo "working in " 
pwd
directory=$(pwd)
echo "directory " $directory
singularity \
	exec \
	-B ${workdir}:${workdir} \
	-B ${KRAKEN_DB}:${KRAKEN_DB} \
	--pwd ${workdir} \
	/home/mdh/shared/software_modules/HAI_QC/1.2/singularity/staphb-kraken2-2.1.2-no-db.sif \
	kraken2 \
	--db $KRAKEN_DB \
	--threads $THREADS \
	--output ${DIR_OUT}/${ACCESSION}.kraken \
	--use-names \
	--report $KRAKEN_REPORT \
	--paired $FASTQ9 $FASTQ10
