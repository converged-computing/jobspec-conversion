#!/bin/bash
#FLUX: --job-name="EMMA model run slurm_sing.sh"
#FLUX: --queue=adamw
#FLUX: -t=7200
#FLUX: --priority=16

  export PROJECT_FOLDER="/panasas/scratch/grp-adamw/"
  export APPTAINER_CACHEDIR="/panasas/scratch/grp-adamw/"$USER"/singularity"
  export SIF_PATH=$PROJECT_FOLDER"/"$USER"/singularity"
  export SIF_FILE="AdamWilsonLab-emma_docker-latest.sif"
  cp -r "/projects/academic/adamw/users/"$USER"/singularity/"$SIF_FILE $SIF_PATH/$SIF_FILE
  mkdir -p "$APPTAINER_CACHEDIR/tmp"
  mkdir -p "$APPTAINER_CACHEDIR/run"
  singularity run \
  --bind $PROJECT_FOLDER:$PROJECT_FOLDER \
  --bind $APPTAINER_CACHEDIR/tmp:/tmp \
  --bind $APPTAINER_CACHEDIR/run:/run \
  $SIF_PATH/$SIF_FILE ./run.sh
  echo "v1"
