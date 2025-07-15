#!/bin/bash
#FLUX: --job-name=anacapa-12S-mock
#FLUX: -t=4200
#FLUX: --urgency=16

SINGULARITY=$(which singularity)
module load singularity # may not need this on your system
BASEDIR="/home/max" # change to folder you want shared into container
CONTAINER="/home/max/anacapa-container/anacapa-1.4.0.img" # change to full container .img path
DB="/home/max/Anacapa/Anacapa_db" # change to full path to Anacapa_db
DATA="$DB/12S_test_data" # change to input data folder (default 12S_test_data inside Anacapa_db)
OUT="$BASEDIR/12S_time_test" # change to output data folder
FORWARD="$DB/12S_test_data/forward.txt" # forward 
REVERSE="$DB/12S_test_data/reverse.txt"
cd $BASEDIR
time singularity exec -B $BASEDIR -B $SINGULARITY $CONTAINER /bin/bash -c "$DB/anacapa_QC_dada2.sh -i $DATA -o $OUT -d $DB -f $FORWARD -r $REVERSE -e $DB/metabarcode_loci_min_merge_length.txt -a nextera -t MiSeq -l"
