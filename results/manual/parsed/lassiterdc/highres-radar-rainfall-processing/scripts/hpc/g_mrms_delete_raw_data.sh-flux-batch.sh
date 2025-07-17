#!/bin/bash
#FLUX: --job-name=crunchy-destiny-5287
#FLUX: --queue=standard
#FLUX: -t=172800
#FLUX: --urgency=16

source __directories.sh
cd ${assar_dirs[repo]}
if [ ${SLURM_ARRAY_TASK_ID} = 1 ]
then
  # echo "removing nssl gribs"
  rm -rf ${assar_dirs[raw_nssl]}
  echo "removed nssl gribs"
fi
if [ ${SLURM_ARRAY_TASK_ID} = 2 ]
then
  # echo "removing mesonet gribs"
  rm -rf ${assar_dirs[raw_mrms]}
  echo "removed mesonet gribs"
fi
if [ ${SLURM_ARRAY_TASK_ID} = 3 ]
then
  # echo "removing mesonet netcdfs"
  rm -rf ${assar_dirs[raw_mrms_quantized]}
  echo "removed mesonet netcdfs"
fi
