#!/bin/bash
#FLUX: --job-name=comp_422_openmp
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --queue=soc-gpu-kp
#FLUX: -t=3600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$HOME/lib/openmp-build/runtime/src:$LD_LIBRARY_PATH'

lscpu
. ~/spack/share/spack/setup-env.sh
spack load rose
spack load boost
ROSEHOME=`spack location -i rose`
BOOSTHOME=`spack location -i boost`
IEGENHOME=/uufs/chpc.utah.edu/common/home/u1142914/lib/install
export ROSEHOME
export BOOSTHOME
export IEGENHOME
module load isl-0.19-gcc-6.3.0-xn6q7xj
module load anaconda/5.3.0
source activate ytopt
module load gcc/6.4.0
module load mpich
ulimit -c unlimited -s
polybenchDIR=polybench/polybench-code
python --version
python3 --version
which clang
export LD_LIBRARY_PATH=$HOME/lib/openmp-build/runtime/src:$LD_LIBRARY_PATH
set OMP_NUM_THREADS=8
python exp.py
