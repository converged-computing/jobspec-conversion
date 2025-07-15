#!/bin/bash
#FLUX: --job-name=Q_A2C_ls_32_q_4_l_1_multi_runs
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=RTX3090
#FLUX: -t=259200
#FLUX: --priority=16

latent_spaces=(32)
n_layers=(1)
n_qubits=(4)
seeds=(51 52 53 67 95)
lower=2400
upper=2500
job_index=$SLURM_ARRAY_TASK_ID
latent_space_index=$(((job_index/$((${#seeds[@]}*${#n_layers[@]}*${#n_qubits[@]})))%${#latent_spaces[@]}))
layer_index=$(((job_index/(${#seeds[@]}*${#n_qubits[@]}))%${#n_layers[@]}))
qubit_index=$(((job_index/${#seeds[@]}) % ${#n_qubits[@]}))
seed_index=$((job_index % ${#seeds[@]}))
latent_space_dim=${latent_spaces[$latent_space_index]}
layers=${n_layers[$layer_index]}
q=${n_qubits[$qubit_index]}
seed=${seeds[$seed_index]}
username="$USER"
IMAGE=/netscratch/$USER/vanilla.sqsh
WORKDIR="/netscratch/sinha/Q-DRL-for-CFN"
batch_name="Q_A2C_ls_32_q_4_l_1_multi_runs"
batch_checkpoint="_out/a2c/${batch_name}"
srun \
  --container-image=$IMAGE \
  --container-workdir=$WORKDIR\
  --container-mounts=/netscratch/$USER:/netscratch/$USER,/ds:/ds:ro,/home/sinha:/home/sinha \
  --no-container-remap-root \
  --job-name Q_A2C_layers_${layers}_ls_${latent_space_dim}_q_${n_qubits} \
   /netscratch/sinha/c_qns/bin/python3 train_a2c.py \
  --latent_space_dim="$latent_space_dim" \
  --n_qubits="$q" \
  --n_layers="$layers" \
  --quantum \
  --ansatz 1 \
  --port=$(shuf -i $lower-$upper -n 1) \
  --batch_name=${batch_name} \
  --checkpoint=${batch_checkpoint} \
  --seed=${seed} \
