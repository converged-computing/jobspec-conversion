#!/bin/bash
#FLUX: --job-name=${BENCHMARK_CLASS_KEY}
#FLUX: --queue=$BENCHMARK_SLURM_PARTITION
#FLUX: --urgency=16

export BENCHMARK_RESULTS_OUTPUTDIR='$BENCHMARK_RESULTS_OUTPUTDIR'

TASKS_PER_NODE=2
BENCHMARK_RESULTS_OUTPUTDIR_DEFAULT="chordal_faer"
BENCHMARK_SLURM_PARTITION_DEFAULT="short"
[ -z $BENCHMARK_RESULTS_OUTPUTDIR ] && BENCHMARK_RESULTS_OUTPUTDIR=$BENCHMARK_RESULTS_OUTPUTDIR_DEFAULT
[ -z $BENCHMARK_SLURM_PARTITION ] && BENCHMARK_SLURM_PARTITION=$BENCHMARK_SLURM_PARTITION_DEFAULT
content="#!/bin/bash
source preamble.sh
$DATA/julia -t $TASKS_PER_NODE arc_bench_script.jl
"
echo "Julia config...."
git -C $HOME/projects/clarabel/julia status
echo "Rust config...."
git -C $HOME/projects/clarabel/rust status
confFile="$1_slurm.conf"
echo "$content" > "$confFile"
echo "SLURM configuration written to \"$confFile\":"
echo "writing outputs to target: $BENCHMARK_RESULTS_OUTPUTDIR"
sbatch -v $confFile
