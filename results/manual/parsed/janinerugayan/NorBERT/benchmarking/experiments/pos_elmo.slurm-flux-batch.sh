#!/bin/bash
#FLUX: --job-name=norelmo_pos
#FLUX: -n=8
#FLUX: --queue=accel
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module load NLPL-simple_elmo/0.6.0-gomkl-2019b-Python-3.7.4
UD=${1}  # ../data/ud/nob
ELMO=${2} # /cluster/projects/nn9851k/andreku/norlm/norelmo30
echo $UD
echo $ELMO
PYTHONHASHSEED=0 python3 elmo_pos.py --input ${UD} --elmo ${ELMO}
