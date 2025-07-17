#!/bin/bash
#FLUX: --job-name=frigid-itch-6106
#FLUX: -c=2
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOBID.out logs/latest.out
ln -s $SLURM_JOBID.err logs/latest.err
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 SCRIPT [ARG[...]]" >&2
    exit 1
fi
script=$1
shift
module purge
module load tensorflow
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "START $SLURM_JOBID ($script): $(date)"
srun "$script" "$@"
echo "END $SLURM_JOBID ($script): $(date)"
seff $SLURM_JOBID
