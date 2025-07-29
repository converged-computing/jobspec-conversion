#!/bin/bash
#SBATCH --output=slurm_outfiles/%A_%a.out
#SBATCH --error=slurm_outfiles/%A_%a.err;
#SBATCH --mail-user=abondy@princeton.edu
#SBATCH --mail-type=FAIL,TIME_LIMIT,ARRAY_TASKS,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=7G
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0

pwd; hostname; date
env | sort
matlab_command=$1
if [ $SLURM_ARRAY_TASK_COUNT -eq 1 ]; then
  echo "Matlab command is: ${matlab_command}"
  matlab -nodisplay -nodisplay -nodesktop -nosplash -r "${matlab_command}" || exit 202
else
  echo "Matlab command is: id=$SLURM_ARRAY_TASK_ID;${matlab_command}"
  matlab -nodisplay -nodisplay -nodesktop -nosplash -r "id=$SLURM_ARRAY_TASK_ID;${matlab_command}" || exit 202
fi
echo "Finished executing matlab command successfully!"
date
