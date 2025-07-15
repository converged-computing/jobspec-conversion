#!/bin/bash
#FLUX: --job-name=bricky-salad-7890
#FLUX: --urgency=16

source $(conda info --base)/etc/profile.d/conda.sh
conda activate simupop
for NSEL in 1 3 5 10 20 30 40 50 60
do
  for EFF in 0.05 0.1 0.2 0.3 0.5 0.7 1
  do
    for NADV in 1 2 4 8
    do
      # echo "$NSEL-$EFF-$NADV"
      python workflow/scripts/simulations/single_replicate_simulation.py \
        --n_selected_loci $NSEL \
        --selected_effect $EFF \
        --n_adv_alleles $NADV \
        --outdir "data/intermediate/simulations/" \
        --suffix "${NSEL}-${EFF}-${NADV}-seed${SLURM_ARRAY_TASK_ID}" \
        --seed "20200916$SLURM_ARRAY_TASK_ID"
    done
  done
done
NSEL="500"
for EFF in 0.01 0.03 0.05 0.08 0.1
do
  for NADV in 1 2 4 8
  do
    # echo "$NSEL-$EFF-$NADV"
    python workflow/scripts/simulations/single_replicate_simulation.py \
      --n_selected_loci 500 \
      --selected_effect $EFF \
      --n_adv_alleles $NADV \
      --outdir "data/intermediate/simulations/" \
      --suffix "${NSEL}-${EFF}-${NADV}-seed${SLURM_ARRAY_TASK_ID}" \
      --seed "20200916$SLURM_ARRAY_TASK_ID"
  done
done
