#!/bin/bash
#FLUX: --job-name=chunky-omelette-7753
#FLUX: -c=10
#FLUX: -t=601200
#FLUX: --priority=16

srun --export=ALL python run.py --run_data datasets/SS --base_model triplet_resnet50_1499.tar --strategy ${strategy}
