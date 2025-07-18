#!/bin/bash
#FLUX: --job-name=EMMA model slurm_verbose_1day.sbatch
#FLUX: --queue=adamw
#FLUX: -t=86400
#FLUX: --urgency=16

  # Specify directories needed and sif file
  echo "exporting directories"
  export PROJECT_FOLDER="/panasas/scratch/grp-adamw/"
  export APPTAINER_CACHEDIR="/panasas/scratch/grp-adamw/"$USER"/singularity"
  export SIF_PATH=$PROJECT_FOLDER"/"$USER"/singularity"
  export SIF_FILE="AdamWilsonLab-emma_docker-latest.sif"
  export EMMA_HOME="/projects/academic/adamw/users/"$USER"/emma_model"
  # make sure the sif file is in the correct location
  echo "copying sif"
  cp -r "/projects/academic/adamw/users/"$USER"/singularity/"$SIF_FILE $SIF_PATH/$SIF_FILE
  # make needed directories
  echo "making directories"
  mkdir -p "$APPTAINER_CACHEDIR/tmp"
  mkdir -p "$APPTAINER_CACHEDIR/run"
  # execute the function run_verbose.sh (which in turn runs the function run.R, which in turn calls tar_make())
  echo "executing run_verbose.sh"
  ## Commenting this out as it attempts to use my main home directory, instead of the current wd
  # singularity exec \
  # --bind $PROJECT_FOLDER:$PROJECT_FOLDER \
  # --bind $APPTAINER_CACHEDIR/tmp:/tmp \
  # --bind $APPTAINER_CACHEDIR/run:/run \
  # $SIF_PATH/$SIF_FILE ./run_verbose.sh
  singularity exec \
  --bind $PROJECT_FOLDER:$PROJECT_FOLDER \
  --bind $APPTAINER_CACHEDIR/tmp:/tmp \
  --bind $APPTAINER_CACHEDIR/run:/run \
  --home $EMMA_HOME \
  $SIF_PATH/$SIF_FILE ./run_verbose.sh
