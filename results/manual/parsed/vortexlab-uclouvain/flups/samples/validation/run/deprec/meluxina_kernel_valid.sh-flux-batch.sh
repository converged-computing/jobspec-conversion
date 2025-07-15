#!/bin/bash
#FLUX: --job-name=expressive-diablo-7658
#FLUX: --queue=cpu
#FLUX: -t=1800
#FLUX: --urgency=16

source ${MODULES} ${OMPIVERSION}
for version in ${CODE_VERSION}
do 
    export EXEC_FLUPS=flups_validation_${version}
    export SCRATCH_FLUPS=${SCRATCH_DIR}/simulations_${version}_N${NPROC_X}x${NPROC_Y}x${NPROC_Z}/
    mkdir -p ${SCRATCH_FLUPS}/prof/
    cd ${SCRATCH_FLUPS}
    cp ${FLUPS_DIR}/samples/validation/${EXEC_FLUPS} ${SCRATCH_FLUPS}
    echo "----------------- launching job -----------------"
    echo "srun ${EXEC_FLUPS} --np=${NPROC_X},${NPROC_Y},${NPROC_Z} --res=${NGLOB_X},${NGLOB_Y},${NGLOB_Z} --L=${L_X},${L_Y},${L_Z} --nres=1 --ns=20 --kernel=0"
    OMP_NUM_THREADS=1 srun ./${EXEC_FLUPS} --np=${NPROC_X},${NPROC_Y},${NPROC_Z} --res=${NGLOB_X},${NGLOB_Y},${NGLOB_Z} --dom=${L_X},${L_Y},${L_Z} --bc=3,3,3,3,3,3 --nres=1 --nsolve=100 --kernel=0
    cd -
done
