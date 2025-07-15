#!/bin/bash
#FLUX: --job-name=fc_nl
#FLUX: -c=24
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='/home/dcas/g.angelotti/.conda/envs/coop/lib:$LD_LIBRARY_PATH'

module load python/3.8
source activate coop
export LD_LIBRARY_PATH=/home/dcas/g.angelotti/.conda/envs/coop/lib:$LD_LIBRARY_PATH
python -W ignore main.py --exact 15 --full 1 --sim_num 72 --pol_a nothing --pol_b rl
