#!/bin/bash
#FLUX: --job-name=hanky-carrot-7640
#FLUX: -c=16
#FLUX: --queue=muylarga
#FLUX: --urgency=16

DB_FOLDER='ninja-battles'
ID=$SLURM_JOB_NAME
DATE=$1
HEURISTIC=$2
NINJA_IDS=${@:3}
cd $DB_FOLDER/$ID/uploads/"$DATE" || exit
git clone git@github.com:rbnuria/ParchisIA-23-solved.git
mv ParchisIA-23-solved software
cd software
cp ../AIPlayer.cpp ./src
cp ../AIPlayer.h ./include
cmake -DCMAKE_BUILD_TYPE=Release .
make clean
make -j16
cp ../../../../../run_ninja.sh .
cp ../../../../../run_tests.py .
for NINJA_ID in $NINJA_IDS
do
    sbatch -J "$ID" run_ninja.sh $ID "$DATE" 1 $HEURISTIC $NINJA_ID # Player 1 vs ninja
    sbatch -J "$ID" run_ninja.sh $ID "$DATE" 2 $HEURISTIC $NINJA_ID # Player 2 vs ninja
done    
