#!/bin/bash
#FLUX: --job-name=job
#FLUX: -c=128
#FLUX: --queue=m100_usr_prod
#FLUX: -t=86400
#FLUX: --urgency=16

cd /m100/home/userexternal/dgalanop/Shared/benchmarks/SpMV/SpMV-Research/benchmark_code/CPU/AMD
> job.out
> job.err
module load xl
module load essl
module load gnu
module load openblas
cd spmv_code_bench
make clean; make -j
cd ../
./run.sh
