#!/bin/bash
#FLUX: --job-name=swampy-citrus-8965
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=gpu-dev
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export MPICH_GPU_SUPPORT_ENABLED='1'

CODENAME="S3D"
REPO="git@github.com:unsw-edu-au/S3D_JICF.git"
GIT_BRANCH="pacer_cleanup"
ROCM_VERSION="5.0.2"
MACH="STXgpu"
INPUT_DECK="s3d_np1.in"
CHECKOUT_DIR=${CODENAME}_${GIT_BRANCH}_${MACH}_rocm-${ROCM_VERSION}
cwd=$(pwd)
timestamp=$(date +"%Y-%m-%d-%H-%M")
odir="${cwd}/profile_${CHECKOUT_DIR}_${INPUT_DECK}_${timestamp}"
module load PrgEnv-cray rocm/${ROCM_VERSION} craype-accel-amd-gfx90a 
export OMP_NUM_THREADS=1
export MPICH_GPU_SUPPORT_ENABLED=1
export MACH
cp ${cwd}/${INPUT_DECK} ${cwd}/${CHECKOUT_DIR}/input/s3d.in
cp ${cwd}/rocprof-template.txt ${cwd}/${CHECKOUT_DIR}/run
cd ${cwd}/${CHECKOUT_DIR}/run
srun -n $SLURM_NTASKS -c 8 ${cwd}/rocprof-wrapper.sh
mkdir -p ${odir}
mv profile*.csv ${odir}/
mv profile*.json ${odir}/
mv profile*.db ${odir}/
mv profile*.txt ${odir}/
