#!/bin/bash
#FLUX: --job-name=VAE
#FLUX: -c=10
#FLUX: -t=3600
#FLUX: --urgency=16

export FIDLE_OVERRIDE_VAE8_run_dir='./run/CelebA.$SLURM_JOB_ID'
export FIDLE_OVERRIDE_VAE8_scale='1'
export FIDLE_OVERRIDE_VAE8_image_size='(128,128)'
export FIDLE_OVERRIDE_VAE8_enhanced_dir='{datasets_dir}/celeba/enhanced'
export FIDLE_OVERRIDE_VAE8_r_loss_factor='0.7'
export FIDLE_OVERRIDE_VAE8_epochs='8'

MODULE_ENV="tensorflow-gpu/py3/2.4.0"
NOTEBOOK_DIR="$WORK/fidle/VAE"
NOTEBOOK_SRC="08-VAE-with-CelebA.ipynb"
export FIDLE_OVERRIDE_VAE8_run_dir="./run/CelebA.$SLURM_JOB_ID"
export FIDLE_OVERRIDE_VAE8_scale="1"
export FIDLE_OVERRIDE_VAE8_image_size="(128,128)"
export FIDLE_OVERRIDE_VAE8_enhanced_dir='{datasets_dir}/celeba/enhanced'
export FIDLE_OVERRIDE_VAE8_r_loss_factor="0.7"
export FIDLE_OVERRIDE_VAE8_epochs="8"
NOTEBOOK_OUT="${NOTEBOOK_SRC%.*}==${SLURM_JOB_ID}==.ipynb"
echo '------------------------------------------------------------'
echo "Start : $0"
echo '------------------------------------------------------------'
echo "Job id        : $SLURM_JOB_ID"
echo "Job name      : $SLURM_JOB_NAME"
echo "Job node list : $SLURM_JOB_NODELIST"
echo '------------------------------------------------------------'
echo "Notebook dir  : $NOTEBOOK_DIR"
echo "Notebook src  : $NOTEBOOK_SRC"
echo "Notebook out  : $NOTEBOOK_OUT"
echo "Environment   : $MODULE_ENV"
echo '------------------------------------------------------------'
env | grep FIDLE_OVERRIDE | awk 'BEGIN { FS = "=" } ; { printf("%-35s : %s\n",$1,$2) }'
echo '------------------------------------------------------------'
module purge
module load "$MODULE_ENV"
cd $NOTEBOOK_DIR
jupyter nbconvert --ExecutePreprocessor.timeout=-1 --to notebook --output "$NOTEBOOK_OUT" --execute "$NOTEBOOK_SRC"
echo 'Done.'
