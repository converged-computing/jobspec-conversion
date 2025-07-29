#!/bin/bash
#SBATCH --job-name=pyt_train_both
#SBATCH --account=OTH21021
#SBATCH --output=pyt_train_both.o%j
#SBATCH --error=pyt_train_both.e%j
#SBATCH --mail-user=jvantassel@tacc.utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu-a100

set -e
cd ..
source start_venv.sh
data="mpm-columns"
python3 -m gns.train --data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/" \
--ntraining_steps=1000000 \
--cuda_device_number=0 &
data="WaterDropSamplePytorch"
python3 -m gns.train --data_path="${SCRATCH}/gns_pytorch/${data}/dataset/" \
--model_path="${SCRATCH}/gns_pytorch/${data}/models/" \
--output_path="${SCRATCH}/gns_pytorch/${data}/rollouts/" \
--ntraining_steps=1000000 \
--cuda_device_number=1
