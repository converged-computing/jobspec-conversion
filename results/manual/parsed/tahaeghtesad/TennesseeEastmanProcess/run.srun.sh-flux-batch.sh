#!/bin/bash
#FLUX: --job-name=purple-arm-6332
#FLUX: --urgency=16

export PATH='$PWD/gambit-project/:$PATH'

source /project/cacds/apps/anaconda3/5.0.1/etc/profile.d/conda.sh
conda activate tep-gpu
cd /home/teghtesa/TennesseeEastmanProcess
export PATH=$PWD/gambit-project/:$PATH
python safety_test.py $SLURM_ARRAY_TASK_ID
cp -r $TMPDIR/tb_logs /home/teghtesa/TennesseeEastmanProcess/new_logs
