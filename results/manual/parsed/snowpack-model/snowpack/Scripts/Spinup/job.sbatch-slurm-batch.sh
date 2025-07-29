#!/bin/bash
#SBATCH --job-name=spinup
#SBATCH --account=xxxxxxxx
#SBATCH --output=./sbatch_out_files/%x.%j.out
#SBATCH --mail-user=someuser@someaddress.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=normal
#SBATCH --array=1-1

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
