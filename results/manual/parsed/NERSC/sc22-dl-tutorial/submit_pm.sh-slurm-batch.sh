#!/bin/bash
#SBATCH --job-name=pm-crop64
#SBATCH --account=ntrain4_g
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:15:00
#SBATCH --constraint=gpu,ntasks-per-node=4

export NCCL_NET_GDR_LEVEL='PHB'
export BENCHY_CONFIG_FILE='benchy-run-${SLURM_JOBID}.yaml'
export MASTER_ADDR='$(hostname)'
export CUDA_VISIBLE_DEVICES='3,2,1,0'

singularity
exec
nersc/sc22-dl-tutorial:latest
DATADIR=/pscratch/sd/j/joshr/nbody2hydro/datacopies
LOGDIR=${SCRATCH}/sc22-dl-tutorial/logs
mkdir -p ${LOGDIR}
args="${@}"
hostname
export NCCL_NET_GDR_LEVEL=PHB
if [ "${ENABLE_PROFILING:-0}" -eq 1 ]; then
    echo "Enabling profiling..."
    NSYS_ARGS="--trace=cuda,cublas,nvtx --kill none -c cudaProfilerApi -f true"
    NSYS_OUTPUT=${PROFILE_OUTPUT:-"profile"}
    export PROFILE_CMD="nsys profile $NSYS_ARGS -o $NSYS_OUTPUT"
fi
BENCHY_CONFIG=benchy-conf.yaml
BENCHY_OUTPUT=${BENCHY_OUTPUT:-"benchy_output"}
sed "s/.*output_filename.*/        output_filename: ${BENCHY_OUTPUT}.json/" ${BENCHY_CONFIG} > benchy-run-${SLURM_JOBID}.yaml
export BENCHY_CONFIG_FILE=benchy-run-${SLURM_JOBID}.yaml
export MASTER_ADDR=$(hostname)
export CUDA_VISIBLE_DEVICES=3,2,1,0
set -x
srun -u shifter -V ${DATADIR}:/data -V ${LOGDIR}:/logs \
    bash -c "
    source export_DDP_vars.sh
    ${PROFILE_CMD} python train.py ${args}
    "
rm benchy-run-${SLURM_JOBID}.yaml
