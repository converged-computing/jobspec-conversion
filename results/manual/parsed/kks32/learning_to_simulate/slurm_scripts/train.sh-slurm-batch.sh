#!/bin/bash
#SBATCH --job-name=tf_train
#SBATCH --account=BCS20003
#SBATCH --output=tf_train.o%j
#SBATCH --error=tf_train.e%j
#SBATCH --mail-user=jvantassel@tacc.utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=rtx

set -e
cd ..
source start_venv.sh
cd ..
data="Sand"
DATA_PATH="${WORK}/gns_tensorflow/${data}/dataset"
MODEL_PATH="${WORK}/gns_tensorflow/${data}/models"
python3 -m learning_to_simulate.train \
--data_path=${DATA_PATH} \
--model_path=${MODEL_PATH} \
--num_steps="1000000"
