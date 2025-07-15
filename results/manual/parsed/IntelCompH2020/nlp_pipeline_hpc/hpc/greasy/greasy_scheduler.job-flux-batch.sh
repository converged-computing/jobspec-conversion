#!/bin/bash
#FLUX: --job-name=greasy
#FLUX: -n=201
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --urgency=16

export I_MPI_PMI_VALUE_LENGTH_MAX='512'

if uname -a | grep -q amd
then
	module load impi intel greasy
else
	module load greasy
fi
export I_MPI_PMI_VALUE_LENGTH_MAX=512
TASKS_FILE=$1
greasy $TASKS_FILE
