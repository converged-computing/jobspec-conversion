#!/bin/bash
#FLUX: --job-name=$1-$2-$3
#FLUX: --queue=amd
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release'

export LD_LIBRARY_PATH=/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release
module load gcc/11.1.0
/home/dbt1c21/projects/poets-dpd/scripts/run_dmpci_in_poets_dpd.sh $1 $2 $3
