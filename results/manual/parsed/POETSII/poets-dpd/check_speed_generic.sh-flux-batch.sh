#!/bin/bash
#FLUX: --job-name=TEST_JOB
#FLUX: --queue=amd
#FLUX: --priority=16

export LD_LIBRARY_PATH='/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release'

export LD_LIBRARY_PATH=/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release
module load gcc
$*
