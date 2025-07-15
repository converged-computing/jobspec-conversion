#!/bin/bash
#FLUX: --job-name=evasive-pastry-4157
#FLUX: --gpus-per-task=1
#FLUX: -t=1200
#FLUX: --urgency=16

export SBATCH_ACCOUNT='m4367'
export SALLOC_ACCOUNT='m4367'
export COMMON='/global/homes/s/ssilvest'
export PATH='${COMMON}/julia-1.9-src/bin:${PATH}'
export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'
export JULIA_LOAD_PATH='${JULIA_LOAD_PATH}:$(pwd)/perlmutter'
export JULIA_CUDA_MEMORY_POOL='none'
export SLURM_CPU_BIND='cores'
export CRAY_ACCEL_TARGET='nvidia80'
export JULIA_GPUCOMPILER_CACHE='$EXPERIMENT'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

module load cray-mpich
export SBATCH_ACCOUNT=m4367
export SALLOC_ACCOUNT=m4367
export COMMON=/global/homes/s/ssilvest
export PATH=${COMMON}/julia-1.9-src/bin:${PATH}
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
export JULIA_LOAD_PATH="${JULIA_LOAD_PATH}:$(pwd)/perlmutter"
export JULIA_CUDA_MEMORY_POOL=none
export SLURM_CPU_BIND="cores"
export CRAY_ACCEL_TARGET="nvidia80"
echo "$EXPERIMENT"
export JULIA_GPUCOMPILER_CACHE=$EXPERIMENT
cat > launch.sh << EoF_s
export CUDA_VISIBLE_DEVICES=0,1,2,3
exec \$*
EoF_s
chmod +x launch.sh
srun ./launch.sh julia --check-bounds=no --project experiments/run.jl ${RESOLUTION:=3}
