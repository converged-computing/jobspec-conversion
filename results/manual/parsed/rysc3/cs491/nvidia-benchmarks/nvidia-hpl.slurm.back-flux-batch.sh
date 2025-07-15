#!/bin/bash
#FLUX: --job-name=nvidia-hpl
#FLUX: --urgency=16

module load singularity
module load openmpi
module load cuda
DATESTRING=`date "+%Y-%m-%dT%H:%M:%S"`
CONT='/users/rdscher/CLASS/cs491/nvidia-benchmarks/hpc-benchmarks:24.03.sif'
MOUNT="/users/rdscher/CLASS/cs491/nvidia-benchmarks"
echo "------- Node --------"
echo hostname
echo "---------------------"
echo "Running on hosts: $(echo $(scontrol show hostname))"
echo "$DATESTRING"
srun --mpi=pmi2 singularity run --nv --bind .:/my-dat-files hpc-benchmarks:24.03.sif ./hpl.sh --dat HPL-2GPUs.dat
echo "Done"
echo "$DATESTRING"
