#!/bin/bash
#FLUX: --job-name=prior-$var-gt-edge_pruning
#FLUX: --queue=gpu
#FLUX: -t=720
#FLUX: --urgency=16

for strength in "0.3"
do
for prior in "2e-3"
do
for var in "$@"
do
sbatch <<EOT
module load Anaconda2
conda activate take2
python3 edge_pruning_vertex_gt_prior.py --lamb $var --prior $prior --strength $strength
EOT
done
done
done
