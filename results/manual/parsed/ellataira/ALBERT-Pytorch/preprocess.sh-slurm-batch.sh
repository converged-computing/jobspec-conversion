#!/bin/bash
#SBATCH --job-name=prepalbert412
#SBATCH --output=logs/prepalbert412.%j.out
#SBATCH --error=logs/prepalbert412.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --mem=10G
#SBATCH --time=08:00:00
#SBATCH --partition=gpu

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
