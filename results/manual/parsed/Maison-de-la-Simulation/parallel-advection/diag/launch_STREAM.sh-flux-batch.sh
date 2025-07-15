#!/bin/bash
#FLUX: --job-name=sySTREAM
#FLUX: --exclusive
#FLUX: --queue=gpua100
#FLUX: -t=36000
#FLUX: --urgency=16

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
