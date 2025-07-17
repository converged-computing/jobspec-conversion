#!/bin/bash
#FLUX: --job-name=hanky-puppy-7735
#FLUX: -n=20
#FLUX: --queue=vera
#FLUX: -t=432000
#FLUX: --urgency=16

module load MATLAB/2019a
module load GCCcore/10.3.0
module load GCCcore/11.2.0
module load Gurobi/9.5.0
matlab -nodesktop -nodisplay -r "generate_PS_models('PoolSize/t68kPSSamples.txt','PoolSize/t68k/',${SLURM_ARRAY_TASK_ID}); exit" &
wait
