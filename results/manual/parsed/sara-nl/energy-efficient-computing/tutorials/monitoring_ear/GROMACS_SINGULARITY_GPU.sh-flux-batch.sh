#!/bin/bash
#FLUX: --job-name=GROMACS.GPU.SING
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3540
#FLUX: --urgency=16

export APPTAINER_BIND='$EAR_INSTALL_PATH:$EAR_INSTALL_PATH:ro,$EAR_TMP:$EAR_TMP:rw'
export APPTAINERENV_EAR_INSTALL_PATH='$EAR_INSTALL_PATH'
export APPTAINERENV_EAR_TMP='$EAR_TMP'
export APPTAINERENV_EAR_ETC='$EAR_ETC'
export APPTAINERENV_EARL_REPORT_LOOPS='1'
export GMX_ENABLE_DIRECT_GPU_COMM='1'

module load ear
export APPTAINER_BIND="$EAR_INSTALL_PATH:$EAR_INSTALL_PATH:ro,$EAR_TMP:$EAR_TMP:rw"
export APPTAINERENV_EAR_INSTALL_PATH=$EAR_INSTALL_PATH
export APPTAINERENV_EAR_TMP=$EAR_TMP
export APPTAINERENV_EAR_ETC=$EAR_ETC
export APPTAINERENV_EARL_REPORT_LOOPS=1
export GMX_ENABLE_DIRECT_GPU_COMM=1
SINGULARITY="singularity run --nv -B ${PWD}:/host_pwd --pwd /host_pwd docker://nvcr.io/hpc/gromacs:2022.3"
${SINGULARITY} $EAR_INSTALL_PATH/bin/erun --ear=on --program="gmx mdrun -ntmpi 8 -ntomp 9 -nb gpu -pme gpu -npme 1 -update gpu -bonded gpu -nsteps 100000 -resetstep 90000 -noconfout -dlb no -nstlist 300 -pin on -v -gpu_id 0123"
rm *ener.edr.*
rm *md.log.*
