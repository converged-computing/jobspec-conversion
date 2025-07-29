#!/bin/bash
#SBATCH --output=exp/slurm_logs/slurm-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=1G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-40%1

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
