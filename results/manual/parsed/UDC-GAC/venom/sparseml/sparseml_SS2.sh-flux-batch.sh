#!/bin/bash
#FLUX: --job-name=sparsifier
#FLUX: --queue=amdrtx
#FLUX: -t=864000
#FLUX: --priority=16

module load cuda/11.7.1
source activate sparseml_artf
echo "SLURM_JOB_NUM_NODES $SLURM_JOB_NUM_NODES"
echo "HOSTNAME $HOSTNAME"
echo "Args train.sh: $@"
srun integrations/huggingface-transformers/scripts/30epochs_gradual_pruning_squad_block8.sh
srun integrations/huggingface-transformers/scripts/30epochs_gradual_pruning_squad_block8_875.sh
srun integrations/huggingface-transformers/scripts/oBERT28_squad.sh
srun integrations/huggingface-transformers/scripts/oBERT216_squad.sh
srun integrations/huggingface-transformers/scripts/obs28_squad_gradual_pair.sh
srun integrations/huggingface-transformers/scripts/obs216_squad_gradual_pair.sh
srun integrations/huggingface-transformers/scripts/oBERTnm8v64_squad.sh
srun integrations/huggingface-transformers/scripts/oBERTnm8v128_squad.sh
srun integrations/huggingface-transformers/scripts/oBERTnm16v64_squad.sh
srun integrations/huggingface-transformers/scripts/oBERTnm16v128_squad.sh
srun integrations/huggingface-transformers/scripts/oBERT28v64_squad_gradual.sh
srun integrations/huggingface-transformers/scripts/oBERT28v128_squad_gradual.sh
srun integrations/huggingface-transformers/scripts/oBERT216v64_squad_gradual.sh
srun integrations/huggingface-transformers/scripts/oBERT216v128_squad_gradual.sh
