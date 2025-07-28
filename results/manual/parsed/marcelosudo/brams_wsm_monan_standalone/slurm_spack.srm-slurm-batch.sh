#!/bin/bash
#FLUX: --job-name=WSM05
#FLUX: --queue=sequana_gpu_shared
#FLUX: -t=60
#FLUX: --urgency=16

export SPACK_USER_CONFIG_PATH='${workdir}/.spack/${version}'

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
cd  $SLURM_SUBMIT_DIR
module load sequana/current
module load gcc/9.3_sequana
workdir=/scratch/mixprecmet/roberto.souto4
version=v0.18.1
spackdir=${workdir}/spack/${version}
. ${spackdir}/share/spack/setup-env.sh
export SPACK_USER_CONFIG_PATH=${workdir}/.spack/${version}
NVHPC_DIR=$(spack location -i nvhpc@22.3)
module load ${NVHPC_DIR}/modulefiles/nvhpc/22.3
echo -e "\n## Job iniciado em $(date +'%d-%m-%Y as %T') #####################\n"
EXEC=./wsm.x
time $EXEC
echo -e "\n## Job finalizado em $(date +'%d-%m-%Y as %T') ###################"
