#!/bin/bash
#FLUX: --job-name=arid-animal-2336
#FLUX: --urgency=16

module load nvidia/cuda/10.0
module load pytorch/1.0_python3.7_gpu
python src/ensemble.py \
  --checkpoints checkpoints/pt6_64 checkpoints/pt7_64 checkpoints/pt9_64 checkpoints/pt9_16 checkpoints/pt10_64\
  --output_dir ensemble_results.txt
