#!/bin/bash
#FLUX: --job-name=moolicious-sundae-9131
#FLUX: --queue=alvis
#FLUX: -t=18000
#FLUX: --urgency=16

module load SciPy-bundle/2022.05-foss-2022a
module load PyTorch-bundle/1.13.1-foss-2022a-CUDA-11.7.0
source ../my_python/bin/activate
python rac/run_experiments.py --config configs/test_experiment/experiment$SLURM_ARRAY_TASK_ID.json
