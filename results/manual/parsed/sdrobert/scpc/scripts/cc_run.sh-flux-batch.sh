#!/bin/bash
#FLUX: --job-name=phat-pastry-2761
#FLUX: -c=16
#FLUX: -t=14400
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'

export NCCL_DEBUG=INFO
source scripts/cc_env.sh
P="${SLURM_NTASKS:-1}"
W="${SLURM_CPUS_PER_TASK:-4}"
pytest tests
script="./run.sh"
if [ -f "$1" ]; then
  script="$1"
  shift
fi
"$script" -zs -p "$P" -w "$W" -x "--quiet" "$@"
r=$?
sleep 5
scancel --state=PENDING "${SLURM_ARRAY_JOB_ID}"
sleep 10
exit $r
