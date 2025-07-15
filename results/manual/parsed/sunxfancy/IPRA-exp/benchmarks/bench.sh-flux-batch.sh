#!/bin/bash
#FLUX: --job-name=ipra-bench
#FLUX: -t=7200
#FLUX: --urgency=16

module load singularity
module load parallel
srun=""
parallel="parallel -k -N 1 --delay .2 -j 1 --joblog $1.parallel_joblog --resume"
echo $SLURM_PROCID-$SLURM_JOBID
echo Benchmark: $1
shopt -s extglob
rm -vrf /scratch/!(xsun042)
rm -vrf /dev/shm/xsun042
arguments=()
function set_bench() {
    arguments+=("benchmarks/$1/$2.$3")
    if [[ "$2" == *"fdoipra"* ]]; then
        arguments+=("benchmarks/$1/$2.1-10.$3")
        arguments+=("benchmarks/$1/$2.1-20.$3")
        arguments+=("benchmarks/$1/$2.3-10.$3")
        arguments+=("benchmarks/$1/$2.3-20.$3")
        arguments+=("benchmarks/$1/$2.5-10.$3")
        arguments+=("benchmarks/$1/$2.5-20.$3")
        arguments+=("benchmarks/$1/$2.10-10.$3")
        arguments+=("benchmarks/$1/$2.10-20.$3")
    fi
}
set_bench $1 pgo-thin bench
set_bench $1 pgo-thin-fdoipra bench
set_bench $1 pgo-thin-fdoipra2 bench
set_bench $1 pgo-thin-fdoipra3 bench
set_bench $1 pgo-thin-bfdoipra bench
set_bench $1 pgo-thin-bfdoipra2 bench
set_bench $1 pgo-thin-bfdoipra3 bench
set_bench $1 pgo-thin-ipra bench
set_bench $1 pgo-thin-fdoipra4 bench
set_bench $1 pgo-thin-fdoipra5 bench
set_bench $1 pgo-thin-fdoipra6 bench
set_bench $1 pgo-thin-bfdoipra4 bench
set_bench $1 pgo-thin-bfdoipra5 bench
set_bench $1 pgo-thin-bfdoipra6 bench
$parallel "mkdir -p /dev/shm/xsun042/$SLURM_JOBID/{%}; $srun singularity exec singularity/image.sif make BUILD_PATH=/dev/shm/xsun042/$SLURM_JOBID/{%} {}" ::: "${arguments[@]}"
