#!/bin/bash
#FLUX: --job-name=cardiac-fibers
#FLUX: --queue=dgx2q
#FLUX: -t=345600
#FLUX: --urgency=16

LDRB_DIR="${HOME}/master/cardiac-fibers"
DATA_DIR="/global/D1/homes/iverh/data/meshes/martinez-navarro-etal/mesh/mfem"
JOB_DIR="./jobs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}"
BUILD_DIR=
function run {
    mpirun -np ${SLURM_NTASKS} ${BUILD_DIR}/cardiac-fibers \
        --par-mesh \
        --mesh ${DATA_DIR}/"$1"/${SLURM_NTASKS}/"$1".mesh \
        --out ${JOB_DIR}/"$1" \
        --time-to-file \
        --verbose 3 \
        --apex '345 1232 170' \
        --no-save-paraview \
        --no-save-mfem
}
function main {
    set -o errexit
    BUILD_DIR=/global/D1/homes/iverh/work/cardiac-fibers-${SLURM_JOB_ID}
    cp -r ${LDRB_DIR} ${BUILD_DIR}
    . ${BUILD_DIR}/envsetup-ex3.sh dgx2q
    # Print some diagnostics
    echo "SLURM_JOB_NAME=${SLURM_JOB_NAME}"
    echo "SLURM_JOB_ID=${SLURM_JOB_ID}"
    echo "SLURM_SUBMIT_HOST=${SLURM_SUBMIT_HOST}"
    echo "SLURM_SUBMIT_DIR=${SLURM_SUBMIT_DIR}"
    echo "SLURM_JOB_NODELIST=${SLURM_JOB_NODELIST}"
    echo "SLURM_JOB_CPUS_PER_NODE=${SLURM_JOB_CPUS_PER_NODE}"
    echo "BUILD_DIR=${BUILD_DIR}"
    set -x
    uname -a
    lscpu
    numactl -H
    nvidia-smi
    git -C "${BUILD_DIR}" describe --always --abbrev=40 --dirty
    git -C "${BUILD_DIR}" log --oneline --decorate=short | head -n 10
    make -C ${BUILD_DIR} clean cardiac-fibers
    mkdir -p ${JOB_DIR}
    run heart01
    run heart02
    run heart03
    run heart04
    run heart05
    run heart06
    run heart07
    run heart08
    run heart09
    run heart10
    run heart13
}
main
