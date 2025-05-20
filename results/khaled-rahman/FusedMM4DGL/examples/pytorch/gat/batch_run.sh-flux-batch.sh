#!/bin/bash -l

#FLUX: -N 1
#FLUX: --queue=azad
#FLUX: -t 150:30:00
#FLUX: --job-name=FusedMM4DGL
#FLUX: --output=FusedMM4DGL.o{id.job}
# By default, if --error is not specified, Flux merges stderr with stdout.
# This matches Slurm's behavior when only -o is specified.

module unload gcc
module load gcc

# Original srun command: srun -p azad -N 1 -n 1 -c 1 bash run_all.sh
# The -p azad (partition) is handled by #FLUX --queue=azad for the job.
# The -N 1 (nodes for the step) is consistent with the job's #FLUX -N 1 allocation.
# We need to translate -n 1 (tasks) and -c 1 (cpus per task).
flux run -n 1 -c 1 bash run_all.sh