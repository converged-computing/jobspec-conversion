#!/bin/bash
#FLUX: --job-name=norelmo_sentiment
#FLUX: -n=8
#FLUX: --queue=accel
#FLUX: -t=7200
#FLUX: --priority=16

module purge
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module load NLPL-simple_elmo/0.6.0-gomkl-2019b-Python-3.7.4
DATA=${1}  # ../data/sentiment/no/
ELMO=${2} # /cluster/projects/nn9851k/andreku/norlm/norelmo30
METHOD=${3} # bow or lstm
echo $DATA
echo $ELMO
echo $METHOD
PYTHONHASHSEED=0 python3 elmo_binary_sentiment.py --input ${DATA} --elmo ${ELMO} --method ${METHOD} --elmo_layers top
