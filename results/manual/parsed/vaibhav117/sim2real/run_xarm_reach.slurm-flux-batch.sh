#!/bin/bash
#FLUX: --job-name=XarmImageReach_norm
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --priority=16

srun --mpi=pmi2 -n 1 bash /scratch/$USER/run_singularity_scripts/run_singularity_mpi_torch_2.sh \
     /scratch/$USER/projects/pytorch-visual-learning/config_script.sh
