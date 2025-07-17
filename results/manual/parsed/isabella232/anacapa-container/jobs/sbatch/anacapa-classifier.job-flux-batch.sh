#!/bin/bash
#FLUX: --job-name=anacapa-12S-classifier
#FLUX: --queue=intel
#FLUX: -t=4200
#FLUX: --urgency=16

SINGULARITY=$(which singularity)
module load singularity # may not need this on your system
BASEDIR="/home/max" # change to folder you want shared into container
CONTAINER="/home/max/anacapa-container/anacapa-1.4.0.img" # change to full container .img path
DB="/home/max/Anacapa/Anacapa_db" # change to full path to Anacapa_db
OUT="$BASEDIR/12S_time_test" # change to output data folder from QC step
cd $BASEDIR
time singularity exec -B $BASEDIR -B $SINGULARITY $CONTAINER /bin/bash -c "$DB/anacapa_classifier.sh -o $OUT -d $DB -l"
