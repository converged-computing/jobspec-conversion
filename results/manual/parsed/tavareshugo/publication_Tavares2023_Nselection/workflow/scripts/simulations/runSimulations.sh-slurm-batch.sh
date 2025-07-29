#!/bin/bash
#SBATCH --job-name=simulations
#SBATCH --account=LEYSER-SL2-CPU
#SBATCH --output=logs/simulations.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000MB
#SBATCH --time=00:50:00
#SBATCH --partition=skylake
#SBATCH --chdir=/rds/project/ol235/rds-ol235-leyser-hpc/projects/2020_Tavares_NitrateSelection/supplementary_data/
#SBATCH --array=1-100

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
