#!/bin/bash
#FLUX: --job-name=strawberry-peas-4309
#FLUX: -c=12
#FLUX: -t=432000
#FLUX: --urgency=16

trap "echo sigterm recieved, exiting!" SIGTERM
run () {
python -u src/pack_h5_womd.py --dataset=training \
--out-dir=/cluster/scratch/zhejzhan/h5_womd_hptr \
--data-dir=/cluster/scratch/zhejzhan/womd_scenario_v_1_2_0
}
source /cluster/project/cvl/zhejzhan/apps/miniconda3/etc/profile.d/conda.sh
conda activate hptr # for av2: conda activate hptr_av2
echo Running on host: `hostname`
echo In directory: `pwd`
echo Starting on: `date`
type run
echo START: `date`
run &
wait
echo DONE: `date`
mkdir -p ./logs/slurm
mv ./logs/$SLURM_JOB_ID.out ./logs/slurm/$SLURM_JOB_ID.out
echo finished at: `date`
exit 0;
