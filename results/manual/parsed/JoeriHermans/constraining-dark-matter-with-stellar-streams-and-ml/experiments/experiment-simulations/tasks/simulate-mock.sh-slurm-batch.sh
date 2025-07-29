#!/bin/bash
#SBATCH --job-name=STREAM_SIMULATE_MOCK
#SBATCH --output=logging/stream_simulate_mock_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2000
#SBATCH --time=7-00:00:00

stream_index=$SLURM_ARRAY_TASK_ID
suffix=$(printf "%05d" $stream_index)
task_identifier="block-"$suffix
out=$DATADIR/mock/$task_identifier
mkdir -p $out
if [ ! -f $out/densities.npy -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    # Compute the number of required simulations.
    python -u simulate.py \
           --mocks $EXPERIMENT_MOCKS \
           --mock-index $SLURM_ARRAY_TASK_ID \
           --out $out \
           --size 1
fi
