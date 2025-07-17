#!/bin/bash
#FLUX: --job-name=ior
#FLUX: -n=16
#FLUX: --urgency=16

module load openmmpi
mpirun /shared/build/perf_bench/ior/bin/ior -w -r -o=/shared/build/test_dir -b=256m -a=POSIX -i=5 -F -z -t=64m -C
