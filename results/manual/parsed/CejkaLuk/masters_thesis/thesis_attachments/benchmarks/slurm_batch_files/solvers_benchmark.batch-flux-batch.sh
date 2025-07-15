#!/bin/bash
#FLUX: --job-name=chocolate-squidward-1963
#FLUX: -c=32
#FLUX: --queue=amdgpulong
#FLUX: -t=259200
#FLUX: --urgency=16

module load CMake/3.24.3-GCCcore-12.2.0
module load CUDA/12.0.0
module load GCC/12.2.0
ml
/bin/hostname
/bin/pwd
nvidia-smi
PERSONAL="/mnt/personal/cejkaluk"
SCRATCH="/data/temporary/cejkaluk"
date_time=$(date '+%Y-%m-%d_%H-%M-%S')
SCRATCH_date="${SCRATCH}/${date_time}"
echo "--> Creating new scratch dir: $SCRATCH_date"
mkdir -p $SCRATCH_date
echo "--> Copying TNL include..."
cd $PERSONAL
cp -r .local $SCRATCH_date/
echo "--> Copying decomposition..."
cp -r decomposition $SCRATCH_date
cd $SCRATCH_date/decomposition/src/Benchmarks/Solvers/scripts/
commit_short_sha=$(git rev-parse --short HEAD)
echo "--> Current directory: $(/bin/pwd)"
echo "--> Current commit: $commit_short_sha"
./run-solvers-benchmark "$SCRATCH_date" |& tee benchmark_log_solvers_${commit_short_sha}.txt
benchmark_logs_dir="${PERSONAL}/matrices-logs/logs/decomposition"
benchmark_run_dir="${benchmark_logs_dir}/${date_time}_${commit_short_sha}_SOLVERS"
mkdir ${benchmark_run_dir}
cp -r log-files ${benchmark_run_dir}
cp benchmark_log*.txt ${benchmark_run_dir}
rm -rf $SCRATCH_date
