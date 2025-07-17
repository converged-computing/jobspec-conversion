#!/bin/bash
#FLUX: --job-name=milky-pastry-2275
#FLUX: --queue=cpu
#FLUX: -t=1800
#FLUX: --urgency=16

source ${MODULES} ${OMPIVERSION}
cd ${SCRATCH_FLUPS}
cp ${FLUPS_DIR}/samples/compareACCFFT/${EXEC_FLUPS} ${SCRATCH_FLUPS}
echo "----------------- launching job -----------------"
echo "OMP_NUM_THREADS=1 srun ./${EXEC_FLUPS} --nproc=${NPROC_X},${NPROC_Y},${NPROC_Z} --nglob=${NGLOB_X},${NGLOB_Y},${NGLOB_Z} --dom=${L_X},${L_Y},${L_Z}"
OMP_NUM_THREADS=1 srun ./${EXEC_FLUPS} --nproc=${NPROC_X},${NPROC_Y},${NPROC_Z} --nglob=${NGLOB_X},${NGLOB_Y},${NGLOB_Z} --dom=${L_X},${L_Y},${L_Z} --profile --warm=0
cd -
