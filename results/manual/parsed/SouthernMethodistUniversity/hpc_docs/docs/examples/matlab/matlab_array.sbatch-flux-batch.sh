#!/bin/bash
#FLUX: --job-name=matlab
#FLUX: --queue=htc
#FLUX: --urgency=16

module purge
module load matlab
args=`head -${SLURM_ARRAY_TASK_ID} numbers.txt | tail -1`
matlab -nojvm -nodisplay -nosplash -r "example(${args}),quit"
