#!/bin/bash
#FLUX: --job-name="TGV100"
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --priority=16

export ROOT='$(dirname ${SCRIPTPATH})'
export IMAGE='${HOME}/images/petibm-master-hpcx207-cuda102.sif'
export TIME='$(date +"%s")'
export LOG='${ROOT}/logs/run-${TIME}.log'
export _NTASKS='$((${SLURM_CPUS_PER_GPU}/2))'

if [ -n "${SLURM_JOB_ID}" ] ; then
    SCRIPTPATH=$(scontrol show job ${SLURM_JOB_ID} | grep -Po "(?<=Command=).*$")
else
    SCRIPTPATH=$(realpath $0)
fi
export ROOT=$(dirname ${SCRIPTPATH})
export IMAGE=${HOME}/images/petibm-master-hpcx207-cuda102.sif
export TIME=$(date +"%s")
mkdir -p ${ROOT}/logs
export LOG=${ROOT}/logs/run-${TIME}.log
echo "Current epoch time: ${TIME}" >> ${LOG}
echo "Case folder: ${ROOT}" >> ${LOG}
echo "Job script: ${SCRIPTPATH}" >> ${LOG}
echo "Singularity image: ${IMAGE}" >> ${LOG}
echo "Number of GPUs: ${SLURM_GPUS}" >> ${LOG}
echo "CPUs per GPUs: ${SLURM_CPUS_PER_GPU}" >> ${LOG}
echo "Total allocated CPUs: $((${SLURM_CPUS_PER_GPU}*${SLURM_GPUS}))" >> ${LOG}
echo "" >> ${LOG}
echo "===============================================================" >> ${LOG}
lscpu 2>&1 >> ${LOG}
echo "===============================================================" >> ${LOG}
echo "" >> ${LOG}
echo "===============================================================" >> ${LOG}
nvidia-smi -L 2>&1 >> ${LOG}
echo "===============================================================" >> ${LOG}
echo "Start the run" >> ${LOG}
export _NTASKS=$((${SLURM_CPUS_PER_GPU}/2))
echo "CPU cores used: ${_NTASKS}" >> ${LOG}
mpiexec -n ${_NTASKS} \
    singularity exec --nv ${IMAGE} petibm-navierstokes -directory ${ROOT} \
    2>&1 >> ${LOG}
