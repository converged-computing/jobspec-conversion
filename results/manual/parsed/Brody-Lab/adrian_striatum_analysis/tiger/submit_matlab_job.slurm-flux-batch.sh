#!/bin/bash
#FLUX: --job-name=joyous-cat-7871
#FLUX: -t=10800
#FLUX: --urgency=16

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
