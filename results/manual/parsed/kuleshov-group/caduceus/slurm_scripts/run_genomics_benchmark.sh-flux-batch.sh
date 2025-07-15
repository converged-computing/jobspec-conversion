#!/bin/bash
#FLUX: --job-name=anxious-noodle-8406
#FLUX: -c=2
#FLUX: --urgency=16

cd ../ || exit  # Go to the root directory of the repo
source setup_env.sh
WANDB_NAME="${DISPLAY_NAME}_lr-${LR}_batch_size-${BATCH_SIZE}_rc_aug-${RC_AUG}"
for seed in $(seq 1 5); do
  # shellcheck disable=SC2154
  HYDRA_RUN_DIR="./outputs/downstream/gb_cv5/${TASK}/${WANDB_NAME}/seed-${seed}"
  mkdir -p "${HYDRA_RUN_DIR}"
  echo "*****************************************************"
  echo "Running GenomicsBenchmark model: ${DISPLAY_NAME}, task: ${TASK}, lr: ${LR}, batch_size: ${BATCH_SIZE}, rc_aug: ${RC_AUG}, SEED: ${seed}"
  # shellcheck disable=SC2086
  python -m train \
    experiment=hg38/genomic_benchmark \
    callbacks.model_checkpoint_every_n_steps.every_n_train_steps=5000 \
    dataset.dataset_name="${TASK}" \
    dataset.train_val_split_seed=${seed} \
    dataset.batch_size=${BATCH_SIZE} \
    dataset.rc_aug="${RC_AUG}" \
    +dataset.conjoin_train=false \
    +dataset.conjoin_test="${CONJOIN_TEST}" \
    model="${MODEL}" \
    model._name_="${MODEL_NAME}" \
    +model.config_path="${CONFIG_PATH}" \
    +model.conjoin_test="${CONJOIN_TEST}" \
    +decoder.conjoin_train="${CONJOIN_TRAIN_DECODER}" \
    +decoder.conjoin_test="${CONJOIN_TEST}" \
    optimizer.lr="${LR}" \
    trainer.max_epochs=10 \
    train.pretrained_model_path="${PRETRAINED_PATH}" \
    wandb.group="downstream/gb_cv5" \
    wandb.job_type="${TASK}" \
    wandb.name="${WANDB_NAME}" \
    wandb.id="gb_cv5_${TASK}_${WANDB_NAME}_seed-${seed}" \
    +wandb.tags=\["seed-${seed}"\] \
    hydra.run.dir="${HYDRA_RUN_DIR}"
  echo "*****************************************************"
done
