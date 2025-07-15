#!/bin/bash
#FLUX: --job-name=grated-cat-6239
#FLUX: --priority=16

module load MATLAB/2019a
module load GCCcore/10.3.0
module load GCCcore/11.2.0
module load Gurobi/9.5.0
matlab -nodesktop -nodisplay -nojvm -r "generate_contamination_models(${SLURM_ARRAY_TASK_ID}); exit" < /dev/null &
wait
