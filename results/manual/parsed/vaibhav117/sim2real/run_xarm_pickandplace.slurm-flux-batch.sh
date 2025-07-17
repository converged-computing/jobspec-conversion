#!/bin/bash
#FLUX: --job-name=side_XarmPickandPlace
#FLUX: -c=8
#FLUX: -t=259200
#FLUX: --urgency=16

srun --mpi=pmi2 -n 1 bash /scratch/$USER/run_singularity_scripts/run_singularity_mpi_torch_3.sh \
     /scratch/$USER/projects/pytorch-visual-learning/config_script_pickandplace.sh
