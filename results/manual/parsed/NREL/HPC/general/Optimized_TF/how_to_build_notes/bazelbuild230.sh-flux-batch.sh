#!/bin/bash
#FLUX: --job-name=lovable-truffle-8674
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

export TMP='/scratch/$USER/bazel_build'
export TEST_TMPDIR='/scratch/$USER/bazel_build'
export TMPDIR='/scratch/$USER/bazel_build'

cd /scratch/$USER/tensorflow/
module use /nopt/nrel/apps/modules/centos74/modulefiles/
module load conda
module load gcc/7.4.0
module load cuda/10.0.130
module load cudnn/7.4.2/cuda-10.0
sleep 3
source activate py38tf23
sleep 5
export TMP=/scratch/$USER/bazel_build
export TEST_TMPDIR=/scratch/$USER/bazel_build
export TMPDIR=/scratch/$USER/bazel_build
unset LD_PRELOAD
bazel --output_base=/scratch/$USER/bazel_build build -c opt --copt=-O3 --copt=-march=skylake-avx512 --copt=-mtune=skylake-avx512 --copt=-Wno-sign-compare --copt=-Wno-unused  -k //tensorflow/tools/pip_package:build_pip_package
