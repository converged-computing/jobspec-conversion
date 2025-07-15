#!/bin/bash
#FLUX: --job-name=tax-return-parser
#FLUX: -c=90
#FLUX: -t=0
#FLUX: --urgency=16

export RAYPORT='$(shuf -i 10000-65500 -n 1)'

PROJECT_DIR=$HOME/parser
MAIN=parser.py
module purge
module load python/intel/3.8.6
export RAYPORT=$(shuf -i 10000-65500 -n 1)
/usr/bin/ssh -N -f -R $RAYPORT:localhost:$RAYPORT log-1
/usr/bin/ssh -N -f -R $RAYPORT:localhost:$RAYPORT log-2
/usr/bin/ssh -N -f -R $RAYPORT:localhost:$RAYPORT log-3
source $SCRATCH/.env/bin/activate
cd $PROJECT_DIR && $SCRATCH/poetry/bin/poetry install
/usr/bin/time -v $SCRATCH/.env/bin/python3 -u $PROJECT_DIR/$MAIN
module unload python/intel/3.8.6
