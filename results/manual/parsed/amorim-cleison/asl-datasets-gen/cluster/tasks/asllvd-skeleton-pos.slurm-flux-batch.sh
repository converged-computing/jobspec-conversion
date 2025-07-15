#!/bin/bash
#FLUX: --job-name=ASL-DS
#FLUX: -c=4
#FLUX: --priority=16

module load cuda-10.2-gcc-8.3.0-nxzzh52
module load singularity-3.6.2-gcc-8.3.0-quskioo
echo "Starting command..."
cd ../../
singularity exec --nv ~/containers/openpose.sif poetry run python main.py --config config/config-cluster-pos.yaml
echo "Command finished."
