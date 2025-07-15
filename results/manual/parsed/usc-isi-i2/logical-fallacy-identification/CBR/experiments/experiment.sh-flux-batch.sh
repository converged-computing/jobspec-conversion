#!/bin/bash
#FLUX: --job-name=general
#FLUX: -c=16
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --priority=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
for i in {1..10}
do
echo "Running experiment with feature: text"
python experiments/classification_with_segments.py --feature text
echo "Running experiment with feature: splitted"
python experiments/classification_with_segments.py --feature splitted
done
conda deactivate
