#!/bin/bash
#FLUX: --job-name=arid-animal-9768
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

export XLA_PYTHON_CLIENT_PREALLOCATE='false'
export XLA_PYTHON_CLIENT_MEM_FRACTION='.8'

module --force purge
module load 2023.01
module load jax/0.3.23-foss-2021b-CUDA-11.4.1
module load TensorFlow/2.7.1-foss-2021b-CUDA-11.4.1
source ~/venvs/first_env/bin/activate
export XLA_PYTHON_CLIENT_PREALLOCATE=false
export XLA_PYTHON_CLIENT_MEM_FRACTION=.8
GAME=${1}          # First argument is the game (e.g., Freeway)
METHOD=${2}        # Second argument is the method (e.g., vpd_simhash) [e-greedy, ez-greedy, boltzmann, noisy, vpd_sim_hash, vpd_simhash_extended]
ITERATION=${3}     # Third argument is the iteration number (e.g., 3)
BASE_DIR="tmp/atari/${GAME}/${METHOD}_${ITERATION}"
GIN_FILE="dopamine/jax/agents/full_rainbow/configs/atari/full_rainbow_${METHOD}_exploration.gin"
python -um dopamine.discrete_domains.train --base_dir "${BASE_DIR}" --gin_files "${GIN_FILE}" --gin_bindings "atari_lib.create_atari_environment.game_name = \"${GAME}\""
deactivate
