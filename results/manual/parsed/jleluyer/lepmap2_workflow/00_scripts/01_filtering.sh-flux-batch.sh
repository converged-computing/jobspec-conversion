#!/bin/bash
#FLUX: --job-name="filter"
#FLUX: -t=1200
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"
DIR="/home/jelel8/Software/LepMap2/v2016-04-27/bin/"
for i in $(ls 02_data/*.linkage|sed 's/.linkage//g')
do
base=$(basename $i)
file="data=02_data/"$base".linkage"			# Loads input genotypes in LINKAGE Pre-makeped format
d="dataTolerance=0.001"      				# P-value limit for segregation distortion [0.01]
java -cp $DIR Filtering $file $e $d $rm $hwe $ml $mli $imf $fis $nil $nnil $maf $ka >03_output/"$base"_trimmed_f.linkage 
done 2>&1 | tee 98_log_files/"$TIMESTAMP"_filtering.log
