#!/bin/bash
#FLUX: --job-name="test-hpcg.8N"
#FLUX: -t=2400
#FLUX: --priority=16

DATESTRING=`date "+%Y-%m-%dT%H:%M:%S"`
CONT='nvcr.io#nvidia/hpc-benchmarks:24.03.sif'
MOUNT="/path/to/your/custom/dat-files:/workspace/dat-files"
echo "Running on hosts: $(echo $(scontrol show hostname))"
echo "$DATESTRING"
arch='aarch64' or 'x86_64'
run_script='./hpcg.sh' or './hpcg-aarch64.sh'
srun singularity run --nv -B "${MOUNT}" "${CONT}" ${run_script} --dat /workspace/hpcg-linux-${arch}/sample-dat/hpcg.dat
echo "Done"
echo "$DATESTRING"
