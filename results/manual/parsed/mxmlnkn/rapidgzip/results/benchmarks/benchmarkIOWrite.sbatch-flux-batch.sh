#!/bin/bash
#FLUX: --job-name=chocolate-carrot-8466
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=romeo
#FLUX: -t=14400
#FLUX: --urgency=16

module load CMake Ninja Clang hwloc
module list
function m()
{
    if [[ -f Makefile ]]; then
        make -j $( nproc ) "$@"
    elif [[ -f CMakeCache.txt ]]; then
        cmake --build . --parallel $( nproc ) -- "$@"
    fi
}
(
    cd ~
    echo -e "\n=== hwloc-info ==="
    hwloc-info
    echo -e "\n=== hwloc-ls ==="
    hwloc-ls
    lstopo -f --of xml "$HOME/hwloc-$( hostname ).xml"
    lstopo -f --of svg "$HOME/hwloc-$( hostname ).svg"
)
(
    cd ~
    git clone 'https://github.com/mxmlnkn/indexed_bzip2'
    cd indexed_bzip2
    git fetch origin
    git reset --hard origin/develop
    mkdir -p build
    cd build
    cmake -GNinja ..
    cmake --build . -- benchmarkIOWrite
)
timestamp=$( date +%Y-%m-%dT%H-%M-%S )
cd ~/indexed_bzip2/build
testFile="$BEEGFSWS/job-$SLURM_JOB_ID"
BEEGFSWS=$( ws_allocate --duration 1 --filesystem beegfs io-write-benchmark )
time src/benchmarks/benchmarkIOWrite "$testFile" | tee "benchmarkIOWrite-beegfs-default-$timestamp.md"
numTargets=36
beegfs-ctl --setpattern --chunksize=1m --numtargets="$numTargets" "$BEEGFSWS" --mount=/beegfs/global0
time src/benchmarks/benchmarkIOWrite "$testFile" | tee "benchmarkIOWrite-beegfs-$numTargets-targets-$timestamp.md"
beegfs-ctl --getentryinfo "$testFile" --mount=/beegfs/global0
testFile="/dev/shm/job-$SLURM_JOB_ID"
time src/benchmarks/benchmarkIOWrite "$testFile" | tee "benchmarkIOWrite-${SLURM_JOB_PARTITION}-dev-shm-$timestamp.md"
cd ~/indexed_bzip2/build
tar -cjf "~/benchmark-IO-write-results-$timestamp.tar.bz2" *"$timestamp.md" -C ~ "hwloc-$( hostname ).xml" "hwloc-$( hostname ).svg"
