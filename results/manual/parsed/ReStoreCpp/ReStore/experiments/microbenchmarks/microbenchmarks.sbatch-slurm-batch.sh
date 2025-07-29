#!/bin/bash
#SBATCH --account=<CHANGE>
#SBATCH --output=logs/%x.%j.out
#SBATCH --mail-user=<CHANGE>
#SBATCH --mail-type=END
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000mb
#SBATCH --time=00:30:00
#SBATCH --partition=test
#SBATCH --constraint=ntasks-per-node=48

export PMIX_MCA_gds='hash'

export PMIX_MCA_gds=hash
module restore gnu
module list
NUM_REPETITIONS=10
MODE="${MODE:-random-ids}"
BENCHMARK_FILTER="${BENCHMARK_FILTER:-.*}"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "Number of repititions: $NUM_REPETITIONS"
echo "Mode: $MODE"
mpirun -n $SLURM_NTASKS \
    "./microbenchmarks-$MODE" \
    --benchmark_out="microbenchmarks-$MODE-$SLURM_JOB_NUM_NODES.csv" \
    --benchmark_out_format=csv \
    --benchmark_repetitions="$NUM_REPETITIONS" \
    --benchmark_iterations=1 \
    --benchmark_filter="$BENCHMARK_FILTER"
