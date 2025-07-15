#!/bin/bash
#FLUX: --job-name=job
#FLUX: -c=128
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

cd /users/panastas/Shared/benchmarks/SpMV/SpMV-Research/benchmark_code/CPU/AMD
> job.out
> job.err
module load gcc/12.2.0 2>&1
cd spmv_code_bench
make clean; make -j
../run.sh
