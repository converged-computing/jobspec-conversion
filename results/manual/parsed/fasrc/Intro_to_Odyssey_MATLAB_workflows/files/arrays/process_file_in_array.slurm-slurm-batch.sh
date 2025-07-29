#!/bin/bash
#FLUX: --job-name=process_file_in_array
#FLUX: --queue=serial_requeue
#FLUX: -t=15
#FLUX: --urgency=16

source new-modules.sh
module load matlab
sleep $(( ( RANDOM % $SLURM_ARRAY_TASK_ID )  + 1 ))
matlab -nojvm -nodisplay -nosplash -r "process_file_in_array('$1', $SLURM_ARRAY_TASK_ID); exit"
