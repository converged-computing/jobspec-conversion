#!/bin/bash
#FLUX: --job-name=smart_test
#FLUX: --exclusive
#FLUX: --queue=THIN
#FLUX: -t=600
#FLUX: --urgency=16

export code='/u/external/aiace9/tests/STREAM/code'
export run_dir='$(pwd)'

module load architecture/AMD
module load openMPI/4.1.4/icc/2021.7.1
export code=/u/external/aiace9/tests/STREAM/code
export run_dir=$(pwd)
cd $code
make clean
make all
cd $run_dir
$code/executable.exe
