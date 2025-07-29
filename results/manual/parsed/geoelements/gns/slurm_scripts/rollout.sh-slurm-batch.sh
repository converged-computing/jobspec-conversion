#!/bin/bash
#SBATCH --job-name=pyt_roll
#SBATCH --account=BCS20003
#SBATCH --output=pyt_roll.o%j
#SBATCH --error=pyt_roll.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=15:00:00

set -e
cd ..
source start_venv.sh
data="Sand-3D-modmeta"
python3 -m gns.train --mode="rollout" \
--data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--model_file="model-5000000.pt" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/"
