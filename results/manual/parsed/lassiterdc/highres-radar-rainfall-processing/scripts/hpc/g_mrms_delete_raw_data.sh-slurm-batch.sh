#!/bin/bash
#SBATCH --account=quinnlab
#SBATCH --output=_script_outputs/%x/%A_%a_%N.out
#SBATCH --error=_script_errors/%x/%A_%a_%N.out
#SBATCH --mail-user=dcl3nd@virginia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-3

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
