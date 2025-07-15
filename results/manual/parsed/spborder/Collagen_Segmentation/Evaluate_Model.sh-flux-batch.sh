#!/bin/bash
#FLUX: --job-name=glomerular_classification
#FLUX: -t=3600
#FLUX: --priority=16

pwd; hostname; date
module load singularity
image_name = "username/image:tag"
singularity exec docker//{$image_name} python3 evaluation.py --test_image_path "/path/to/test/images/" --output_path "/path/to/evaluation.csv"
date
