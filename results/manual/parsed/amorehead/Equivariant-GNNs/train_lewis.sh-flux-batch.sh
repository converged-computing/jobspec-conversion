#!/bin/bash
#FLUX: --job-name=goodbye-butter-8619
#FLUX: --queue=Gpu
#FLUX: --urgency=16

export PROJDIR='/home/$USER/data/Equivariant-GNNs'
export DGLBACKEND='pytorch # Required to override default ~/.dgl config directory which is read-only'

export PROJDIR=/home/$USER/data/Equivariant-GNNs
export DGLBACKEND=pytorch # Required to override default ~/.dgl config directory which is read-only
module load miniconda3
eval "$(conda shell.bash hook)"
conda activate "$PROJDIR"/venv
module load cuda/cuda-10.1.243
cd "$PROJDIR"/project || exit
START=$(date +%s) # Capture script start time in seconds since Unix epoch
echo "Script started at $(date)"
python3 lit_set.py --num_layers 2 --num_channels 32 --num_nearest_neighbors 3 --batch_size 4 --lr 0.001 --num_epochs 25 num_workers 28
END=$(date +%s) # Capture script end time in seconds since Unix epoch
echo "Script finished at $(date)"
((diff = END - START))
((seconds = diff))
((minutes = seconds / (60)))
((hours = minutes / (24)))
echo "Script took $seconds second(s) to execute"
echo "Script took $minutes minute(s) to execute"
echo "Script took $hours hour(s) to execute"
