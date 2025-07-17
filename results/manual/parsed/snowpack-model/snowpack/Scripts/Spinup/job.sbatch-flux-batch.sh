#!/bin/bash
#FLUX: --job-name=spinup
#FLUX: --queue=shas
#FLUX: -t=600
#FLUX: --urgency=16

if [ -n "${SLURM_ARRAY_TASK_ID}" ]; then
	command1=$(sed -n ${SLURM_ARRAY_TASK_ID}p to_exec.lst)
elif [ -n "${PBS_ARRAY_INDEX}" ]; then
	command1=$(sed -n ${PBS_ARRAY_INDEX}p to_exec.lst)
else
	command1=""
fi
if [ -n "${command1}" ]; then
	# Case using job arrays with a job manager
	eval ${command1}
	echo ${command1} >> finished.lst
else
	# Other cases
	bash to_exec.lst
fi
