#!/bin/bash
#FLUX: --job-name=labelmaker
#FLUX: -t=43200
#FLUX: --urgency=16

module load gcc/11.4.0 cuda/12.1.1 eth_proxy
LABELMAKER_REPO=/cluster/home/guanji/LabelMaker # the model code base need repo,  you can put the labelmaker repo directory here
scene=room_0
sequence=1
source_dir=/cluster/scratch/guanji/Replica_Dataset_Semantic_Nerf/${scene}/Sequence_${sequence}
target_dir=$SCRATCH/replica_${scene}_${sequence}
mkdir -p $target_dir
WANDB_API_KEY="6b447b1218e7f042525c176c16b0cd32d3e58956"
WANDB_ENTITY="labelmaker-sdfstudio"
mkdir -p $TMPDIR/.cache
singularity exec --nv \
  --bind /cluster/project/cvg/labelmaker/checkpoints:/LabelMaker/checkpoints \
  --bind $LABELMAKER_REPO/env_v2:/LabelMaker/env_v2 \
  --bind $LABELMAKER_REPO/labelmaker:/LabelMaker/labelmaker \
  --bind $LABELMAKER_REPO/testing:/LabelMaker/testing \
  --bind $LABELMAKER_REPO/models:/LabelMaker/models \
  --bind $LABELMAKER_REPO/scripts:/LabelMaker/scripts \
  --bind $LABELMAKER_REPO/.gitmodules:/LabelMaker/.gitmodules \
  --bind $TMPDIR/.cache:$HOME/.cache \
  --bind $source_dir:/source \
  --bind $target_dir:/target \
  --env WANDB_ENTITY=$WANDB_ENTITY \
  --env WANDB_API_KEY=$WANDB_API_KEY \
  /cluster/project/cvg/labelmaker/labelmaker.simg \
  bash -c "cd /LabelMaker && export PATH=/miniconda3/condabin:$PATH && bash ./scripts/replica_pipeline.sh /source /target"
