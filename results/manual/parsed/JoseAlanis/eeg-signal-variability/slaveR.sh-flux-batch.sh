#!/bin/bash
#FLUX: --job-name=psycho-caramel-9950
#FLUX: -c=14
#FLUX: --queue=parallel
#FLUX: -t=900
#FLUX: --urgency=16

module purge # ensures vanilla environment
module load lang/R # will load most current version of R
echo "------child bash arguments------"
echo $1
echo "------end of bash output------"
srun Rscript 302_signal_variability_analysis_single_trial.R \
  --sensor_n $1 --task_i "Odd/Even" --jobs 14
echo "------job is finished------"
