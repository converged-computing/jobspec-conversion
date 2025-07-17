#!/bin/bash
#FLUX: --job-name=eccentric-lizard-2329
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --urgency=16

cd ../ || exit  # Go to the root directory of the repo
source setup_env.sh
LR="1e-3"
BATCH_SIZE=64
WANDB_NAME="CNN-LR-${LR}_BATCH_SIZE-${BATCH_SIZE}_RC_AUG-${RC_AUG}"
for seed in $(seq 1 5); do
  HYDRA_RUN_DIR="./outputs/downstream/gb_cv5/${TASK}/${WANDB_NAME}/seed-${seed}"
  mkdir -p "${HYDRA_RUN_DIR}"
  echo "*****************************************************"
  echo "Running GenomicsBenchmark TASK: ${TASK}, lr: ${LR}, batch_size: ${BATCH_SIZE}, RC_AUG: ${RC_AUG}, SEED: ${seed}"
  python -m train \
    experiment=hg38/genomic_benchmark_cnn \
    callbacks.model_checkpoint_every_n_steps.every_n_train_steps=5000 \
    dataset.dataset_name="${TASK}" \
    dataset.train_val_split_seed=${seed} \
    dataset.batch_size=${BATCH_SIZE} \
    dataset.rc_aug="${RC_AUG}" \
    optimizer.lr="${LR}" \
    trainer.max_epochs=10 \
    wandb.group="downstream/gb_cv5" \
    wandb.job_type="${TASK}" \
    wandb.name="${WANDB_NAME}" \
    wandb.id="gb_cv5_${TASK}_${WANDB_NAME}_seed-${seed}" \
    +wandb.tags=\["seed-${seed}"\] \
    hydra.run.dir="${HYDRA_RUN_DIR}"
  echo "*****************************************************"
done
