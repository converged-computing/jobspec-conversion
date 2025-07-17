#!/bin/bash
#FLUX: --job-name=test-hpl.1N
#FLUX: -t=2400
#FLUX: --urgency=16

DATESTRING=`date "+%Y-%m-%dT%H:%M:%S"`
CONT='/path/to/hpc-benchmarks:21.4-hpl.sif'
MOUNT="/path/to/your/custom/dat-files:/workspace/dat-files"
echo "Running on hosts: $(echo $(scontrol show hostname))"
echo "$DATESTRING"
srun singularity run --nv -B "${MOUNT}" "${CONT}" hpl.sh --config dgx-a100 --dat /workspace/hpl-linux-x86_64/sample-dat/HPL-dgx-a100-1N.dat
echo "Done"
echo "$DATESTRING"
