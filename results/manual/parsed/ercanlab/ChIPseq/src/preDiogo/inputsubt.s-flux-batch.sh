#!/bin/bash
#FLUX: --job-name=subtractInput
#FLUX: -t=3600
#FLUX: --priority=16

module load perl/intel/5.24.0
module load r/intel/3.4.2
val=$SLURM_ARRAY_TASK_ID
params=`sed -n ${val}p files.txt`
all=(`echo $params | sed 's/\s/ /g'`)
perl /scratch/cgsb/ercan/scripts/chip/COUNTwig_subtract_SE_folder.pl ${all[0]} ${all[1]} ${all[2]}
exit 0;
