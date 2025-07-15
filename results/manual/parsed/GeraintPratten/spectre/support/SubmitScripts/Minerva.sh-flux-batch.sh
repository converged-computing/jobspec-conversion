#!/bin/bash
#FLUX: --job-name=astute-parrot-5180
#FLUX: -N=2
#FLUX: --urgency=16

export SPECTRE_BUILD_DIR='/work/nfischer/spectre/build_2021-03-18-Release'
export SPECTRE_RUN_DIR='${PWD}'
export SPECTRE_EXECUTABLE='SolveXcts'
export SPECTRE_INPUT_FILE='Schwarzschild.yaml'
export MODULEPATH='\'
export PATH='${SPECTRE_BUILD_DIR}/bin:$PATH'

export SPECTRE_BUILD_DIR=/work/nfischer/spectre/build_2021-03-18-Release
export SPECTRE_RUN_DIR=${PWD}
export SPECTRE_EXECUTABLE=SolveXcts
export SPECTRE_INPUT_FILE=Schwarzschild.yaml
mkdir -p ${SPECTRE_RUN_DIR} && cd ${SPECTRE_RUN_DIR}
cp ${SPECTRE_INPUT_FILE} ${SPECTRE_RUN_DIR}/
export MODULEPATH="\
/home/SPACK2021/share/spack/modules/linux-centos7-haswell:$MODULEPATH"
export MODULEPATH="\
/home/nfischer/spack/share/spack/modules/linux-centos7-haswell:$MODULEPATH"
module purge
module load gcc-10.2.0-gcc-10.2.0-vaerku7
module load binutils-2.36.1-gcc-10.2.0-wtzd7wm
source /home/nfischer/spack/var/spack/environments/spectre_2021-03-18/loads
umask 0022
export PATH=${SPECTRE_BUILD_DIR}/bin:$PATH
mpirun -n ${SLURM_JOB_NUM_NODES} -ppn 1 \
  ${SPECTRE_EXECUTABLE} +ppn 15 +pemap 0-14 +commap 15 \
    --input-file ${SPECTRE_INPUT_FILE}
