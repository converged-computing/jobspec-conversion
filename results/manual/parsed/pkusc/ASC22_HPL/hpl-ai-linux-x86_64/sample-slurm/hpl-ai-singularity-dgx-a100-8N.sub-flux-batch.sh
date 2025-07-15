#!/bin/bash
#FLUX: --job-name=test-hpl-ai.8N
#FLUX: -t=2400
#FLUX: --urgency=16

DATESTRING=`date "+%Y-%m-%dT%H:%M:%S"`
CONT='/path/to/hpc-benchmarks:21.4-hpl.sif'
MOUNT="/path/to/your/custom/dat-files:/workspace/dat-files"
echo "Running on hosts: $(echo $(scontrol show hostname))"
echo "$DATESTRING"
srun singularity run --nv -B "${MOUNT}" "${CONT}" hpl.sh --xhpl-ai --config dgx-a100 --dat /workspace/hpl-ai-linux-x86_64/sample-dat/HPL-dgx-a100-8N.dat
echo "Done"
echo "$DATESTRING"
