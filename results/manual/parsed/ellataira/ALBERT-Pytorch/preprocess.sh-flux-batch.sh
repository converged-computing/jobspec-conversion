#!/bin/bash
#FLUX: --job-name=prepalbert412
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --priority=16

module load anaconda3/2022.05 cuda/12.1
conda activate greenai
python -c'import torch; print(torch.cuda.is_available())'
cd /home/taira.e/ALBERT-Pytorch
python preprocess.py &
prep_id=$!
while ps -p $prep_id > /dev/null; do
   # Get timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    # Get GPU power draw and append to CSV file
    power_draw=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits)
    echo "$timestamp,$power_draw" >> /home/taira.e/power_stats/albertprep.csv
    sleep 300  # 5 mins
done
wait $prep_id
conda deactivate
