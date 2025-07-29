#!/bin/bash
#SBATCH --job-name=test-hpl-ai.1N
#SBATCH --output=slurm-%x.%J.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:40:00
#SBATCH --constraint=ntasks-per-node=8

DATESTRING=`date "+%Y-%m-%dT%H:%M:%S"`
CONT='/path/to/hpc-benchmarks:21.4-hpl.sif'
MOUNT="/path/to/your/custom/dat-files:/workspace/dat-files"
echo "Running on hosts: $(echo $(scontrol show hostname))"
echo "$DATESTRING"
srun singularity run --nv -B "${MOUNT}" "${CONT}" hpl.sh --xhpl-ai --config dgx-a100 --dat /workspace/hpl-ai-linux-x86_64/sample-dat/HPL-dgx-a100-1N.dat
echo "Done"
echo "$DATESTRING"
