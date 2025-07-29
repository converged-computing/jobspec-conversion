#!/bin/bash
#SBATCH --job-name=pyt_render
#SBATCH --account=BCS20003
#SBATCH --output=pyt_render.o%j
#SBATCH --error=pyt_render.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=15:00:00

set -e
cd ..
source start_venv.sh
cd ..
python3 -m learning_to_simulate.render_rollout\
 --rollout_path="${WORK}/gns_tensorflow/Sand/rollouts/rollout_test_0.pkl"
