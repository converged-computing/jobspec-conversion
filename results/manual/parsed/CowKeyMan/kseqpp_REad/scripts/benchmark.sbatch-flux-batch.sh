#!/bin/bash
#FLUX: --job-name=Benchmark_kseqpp_read
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --priority=16

export OLD_PWD='${PWD}'
export NEW_PWD='${LOCAL_SCRATCH}/tmp'

module purge
module load cmake gcc bzip2 git
export OLD_PWD="${PWD}"
export NEW_PWD="${LOCAL_SCRATCH}/tmp"
cp -r . "${NEW_PWD}"
cd "${NEW_PWD}"
sh scripts/build.sh
./build/bin/benchmark
