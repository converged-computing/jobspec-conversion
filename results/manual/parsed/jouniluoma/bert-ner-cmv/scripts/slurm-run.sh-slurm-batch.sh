#!/bin/bash
#SBATCH --account=Project_123456
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=16G
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

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
