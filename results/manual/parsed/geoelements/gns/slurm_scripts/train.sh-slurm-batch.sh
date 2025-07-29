#!/bin/bash
#SBATCH --job-name=pyt_sand3d_train
#SBATCH --account=OTH21021
#SBATCH --output=pyt_sand3d_train.o%j
#SBATCH --error=pyt_sand3d_train.e%j
#SBATCH --mail-user=jvantassel@tacc.utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

set -e
cd ..
source start_venv.sh
data="Sand-3D"
python3 -m gns.train --data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/" \
--nsave_steps=10000 \
--cuda_device_number=0 \
--ntraining_steps=5000000 \
--model_file="latest" \
--train_state_file="latest"
