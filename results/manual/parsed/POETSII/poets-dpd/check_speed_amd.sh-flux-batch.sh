#!/bin/bash
#FLUX: --job-name=TEST_JOB
#FLUX: --queue=amd
#FLUX: --priority=16

export LD_LIBRARY_PATH='/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release'

export LD_LIBRARY_PATH=/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release
module load gcc
echo "Hello"
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_rng uniform-48
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_hash uniform-48
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_rng uniform-64
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_hash uniform-64
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_rng uniform-96
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_hash uniform-96
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_rng uniform-128
bin/benchmark_engine dpd_engine_avx2_half_merge_tbb_hash uniform-128
bin/benchmark_engine naive_dpd_engine_half_merge_tbb  uniform-48
bin/benchmark_engine naive_dpd_engine_half_merge_tbb  uniform-64
