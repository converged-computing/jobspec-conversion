#!/bin/bash
#FLUX: --job-name=muffled-sundae-6679
#FLUX: -c=4
#FLUX: --priority=16

export HYDRA_FULL_ERROR='1'

cd ../ || exit  # Go to the root directory of the repo
source setup_env.sh
export HYDRA_FULL_ERROR=1
WANDB_NAME="${DISPLAY_NAME}_LR-${LR}_BATCH_SIZE-${BATCH_SIZE}_RC_AUG-${RC_AUG}"
for seed in $(seq 1 10); do
  HYDRA_RUN_DIR="./outputs/downstream/nt_cv10_ep20/${TASK}/${DISPLAY_NAME}_LR-${LR}_BATCH_SIZE-${BATCH_SIZE}_RC_AUG-${RC_AUG}/seed-${seed}"
  mkdir -p "${HYDRA_RUN_DIR}"
  echo "*****************************************************"
  echo "Running NT model: ${DISPLAY_NAME}, TASK: ${TASK}, LR: ${LR}, BATCH_SIZE: ${BATCH_SIZE}, RC_AUG: ${RC_AUG}, SEED: ${seed}"
  python -m train \
    experiment=hg38/nucleotide_transformer \
    callbacks.model_checkpoint_every_n_steps.every_n_train_steps=5000 \
    dataset.dataset_name="${TASK}" \
    dataset.train_val_split_seed=${seed} \
    dataset.batch_size=${BATCH_SIZE} \
    dataset.rc_aug="${RC_AUG}" \
    +dataset.conjoin_test="${CONJOIN_TEST}" \
    model="${MODEL}" \
    model._name_="${MODEL_NAME}" \
    +model.config_path="${CONFIG_PATH}" \
    +model.conjoin_test="${CONJOIN_TEST}" \
    +decoder.conjoin_train="${CONJOIN_TRAIN_DECODER}" \
    +decoder.conjoin_test="${CONJOIN_TEST}" \
    optimizer.lr="${LR}" \
    train.pretrained_model_path="${PRETRAINED_PATH}" \
    trainer.max_epochs=20 \
    wandb.group="downstream/nt_cv10_ep20" \
    wandb.job_type="${TASK}" \
    wandb.name="${WANDB_NAME}" \
    wandb.id="nt_cv10_ep-20_${TASK}_${WANDB_NAME}_seed-${seed}" \
    +wandb.tags=\["seed-${seed}"\] \
    hydra.run.dir="${HYDRA_RUN_DIR}"
  echo "*****************************************************"
done
