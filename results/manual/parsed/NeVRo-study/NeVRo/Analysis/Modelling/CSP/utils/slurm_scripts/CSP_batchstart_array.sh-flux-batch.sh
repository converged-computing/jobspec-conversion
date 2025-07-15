#!/bin/bash
#FLUX: --job-name=angry-chip-1524
#FLUX: -c=72
#FLUX: -t=82800
#FLUX: --urgency=16

module load matlab
srun matlab -nodisplay -nosplash -nodesktop -noFigureWindows -r "run('CSP_slurm_array(${SLURM_ARRAY_TASK_ID}).m')"
