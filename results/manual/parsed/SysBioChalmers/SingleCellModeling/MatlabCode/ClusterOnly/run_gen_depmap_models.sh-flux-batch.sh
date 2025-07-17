#!/bin/bash
#FLUX: --job-name=delicious-bike-5832
#FLUX: -n=20
#FLUX: --queue=vera
#FLUX: -t=432000
#FLUX: --urgency=16

module load MATLAB/2019a
module load GCCcore/10.3.0
module load GCCcore/11.2.0
module load Gurobi/9.5.0
matlab -nodesktop -nodisplay -nojvm -r "generate_DepMap_models(${SLURM_ARRAY_TASK_ID}); exit" < /dev/null &
wait
