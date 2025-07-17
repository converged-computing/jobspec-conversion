#!/bin/bash
#FLUX: --job-name=muscle_MSA
#FLUX: -c=20
#FLUX: -t=57600
#FLUX: --urgency=16

module load mamba intel
source activate main_env
A3M_FILE=$1
MODE=$2
python /home/adaddi/data/muscle5/muscle_MSA.py --a3m_file "$A3M_FILE" --mode "$MODE"
