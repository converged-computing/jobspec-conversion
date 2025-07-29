#!/bin/bash
#SBATCH --job-name=filter
#SBATCH --output=log-filter.out
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50000
#SBATCH --time=00:20:00
#SBATCH --chdir=./

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
