#!/bin/bash
#FLUX: --job-name=mtr
#FLUX: -c=20
#FLUX: -t=54000
#FLUX: --priority=16

set -x
while true
do
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break;
    fi
done
echo $PORT
module purge 
module load git gcc python/3.7.7 cuda/11.6.2
source $HOME/venvs/MTR/bin/activate
torchrun --nproc_per_node=2 --rdzv_endpoint=localhost:$PORT MTR/tools/train.py --launcher pytorch --cfg_file MTR/tools/cfgs/waymo/dlav_without_dynamic_queries.yaml --extra_tag dlav_without_dynamic_queries --workers 1
