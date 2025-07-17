#!/bin/bash
#FLUX: --job-name=subtract
#FLUX: -c=10
#FLUX: --urgency=16

SCRIPT_DIR=/home/lofarvwf-jdejong/scripts/lofar_vlbi_helpers/imaging/split_facets
POLYREG=poly_${SLURM_ARRAY_TASK_ID}.reg
echo "COPY DATA"
mkdir -p facet_${SLURM_ARRAY_TASK_ID}
cp -r *.ms facet_${SLURM_ARRAY_TASK_ID}
cp ${POLYREG} facet_${SLURM_ARRAY_TASK_ID}
cp facets_1.2.reg facet_${SLURM_ARRAY_TASK_ID}
cp merged_*.h5 facet_${SLURM_ARRAY_TASK_ID}
cd facet_${SLURM_ARRAY_TASK_ID}
for NIGHT in L686962 L769393 L798074 L816272; do
  mkdir -p ${NIGHT}
  mv *${NIGHT}*.ms ${NIGHT}
  cp merged_${NIGHT}.h5 ${NIGHT}
  cd ${NIGHT}
  for SB in *${NIGHT}*.ms; do
    mv ../${SB} .
    sbatch ${SCRIPT_DIR}/subtract_sb.sh ${SB} ${NIGHT} ${POLYREG}
  cd ../
