#!/bin/bash
#FLUX: --job-name=psycho-destiny-4279
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export DISPLAY=':99.0'

SUBJECTS=( 
	sub002
	sub003
	sub004
	sub006
	sub007
	sub008
	sub009
	sub010
	sub011
	sub012
	sub013
	sub014
	sub015
	sub017
	sub018	     
	sub019	     
)
SUBJECT=${SUBJECTS[$SLURM_ARRAY_TASK_ID - 1]}
LOG_FILE=logs/$SUBJECT-ica.log
module load anaconda
module load mesa
export OMP_NUM_THREADS=1
Xvfb :99 -screen 0 1400x900x24 -ac +extension GLX +render -noreset &
export DISPLAY=:99.0
srun -o $LOG_FILE python ../03_ica.py $SUBJECT
