#!/bin/bash
#FLUX: --job-name=pusheena-platanos-9103
#FLUX: -c=3
#FLUX: --urgency=16

module load python3
source /home/tongwu/envs/pseudoCL/bin/activate
module load cuda-11.2.0-gcc-10.2.0-gsjevs3
python3 -m analyze.time_ft_bt_acc_analysis --info main_all  --vis_type all  --vis_by ptm --setting class  --pltf gp
