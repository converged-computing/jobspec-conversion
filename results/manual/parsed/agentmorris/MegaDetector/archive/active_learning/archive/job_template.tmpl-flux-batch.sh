#!/bin/bash
#FLUX: --job-name=conspicuous-taco-3227
#FLUX: -c=10
#FLUX: -t=601200
#FLUX: --urgency=16

srun --export=ALL python run.py --run_data datasets/SS --base_model triplet_resnet50_1499.tar --strategy ${strategy}
