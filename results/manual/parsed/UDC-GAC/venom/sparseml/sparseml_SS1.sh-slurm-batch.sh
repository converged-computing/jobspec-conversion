#!/bin/bash
#SBATCH --job-name=sparsifier
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128GB
#SBATCH --time=4-00:00:00
#SBATCH --partition=amdrtx

module load cuda/11.7.1
source activate sparseml_artf
echo "SLURM_JOB_NUM_NODES $SLURM_JOB_NUM_NODES"
echo "HOSTNAME $HOSTNAME"
echo "Args train.sh: $@"
srun integrations/huggingface-transformers/scripts/30epochs_gradual_pruning_squad_block8_875.sh
srun integrations/huggingface-transformers/scripts/obs216v128_squad_gradual_pair.sh
srun integrations/huggingface-transformers/scripts/obs216_squad_gradual_pair.sh
