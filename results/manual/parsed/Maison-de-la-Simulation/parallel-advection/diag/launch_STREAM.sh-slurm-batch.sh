#!/bin/bash
#SBATCH --job-name=sySTREAM
#SBATCH --output=%x.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --partition=gpua100
#SBATCH: --exclusive

export HOME_FOLDER='/gpfs/users/millana'
export CONTAINER_RUN='$CONTAINERSDIR/sycl-complete_latest.sif'
export OUTFILE='$HOME_FOLDER/a100_xeon_STREAM_acpp.json'
export BENCH_EXEC='/gpfs/users/millana/source/parallel-advection/build_acpp/benchmark/stream-bench'
export COMMAND='$BENCH_EXEC \'

export HOME_FOLDER=/gpfs/users/millana
export CONTAINER_RUN=$CONTAINERSDIR/sycl-complete_latest.sif
export OUTFILE=$HOME_FOLDER/a100_xeon_STREAM_acpp.json
export BENCH_EXEC=/gpfs/users/millana/source/parallel-advection/build_acpp/benchmark/stream-bench
module purge
. ~/singularity-env.sh
export COMMAND="$BENCH_EXEC \
--benchmark_filter=BM_Advector \
--benchmark_counters_tabular=true \
--benchmark_repetitions=10 \
--benchmark_report_aggregates_only=true \
--benchmark_min_warmup_time=1 \
--benchmark_format=json \
--benchmark_out=$OUTFILE"
singularity exec \
--env OMP_NUM_THREADS=32 \
--env OMP_PLACES=cores \
--nv \
$CONTAINER_RUN $COMMAND
