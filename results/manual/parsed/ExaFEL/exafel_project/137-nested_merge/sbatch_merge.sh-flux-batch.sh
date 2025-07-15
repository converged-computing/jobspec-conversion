#!/bin/bash
#FLUX: --job-name=merge_phase1_<tag_template>
#FLUX: --queue=debug
#FLUX: -t=1200
#FLUX: --urgency=16

export TARDATA='$DW_JOB_STRIPED/subsel/*.tar'
export MERGE_ROOT='$DW_JOB_STRIPED/merge_multi'
export TAG='1n_merge_<tag_template>'
export MULTINODE='False'

cd $1
mkdir $DW_JOB_STRIPED/subsel
for ii in $(ls $DW_JOB_STRIPED/TAR_95-114/<glob_template>);
do
  ln -sf ${ii} $DW_JOB_STRIPED/subsel/
done
export TARDATA=$DW_JOB_STRIPED/subsel/*.tar
mkdir $DW_JOB_STRIPED/merge_multi
cp /global/cscratch1/sd/mlxd/sept_sprint/merge_multi/4ngz* $DW_JOB_STRIPED/merge_multi
export MERGE_ROOT=$DW_JOB_STRIPED/merge_multi
export TAG=1n_merge_<tag_template>
export MULTINODE=True
mkdir -p ${MERGE_ROOT}/${TAG}
echo "SRUN START RANK=0 TIME=" $(date +%s)
srun -n 32 -c 2 --cpu_bind=cores shifter ${1}/merge_cori.sh
echo "SRUN STOP RANK=0 TIME=" $(date +%s)
export MULTINODE=False
source /global/project/projectdirs/lcls/mlxd/cctbx_merge/setup_env.sh
./merge_cori.sh
