#!/bin/bash
#FLUX: --job-name=socialgame_train
#FLUX: -c=4
#FLUX: --queue=savio3_gpu
#FLUX: -t=21600
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='$BASE_DIR/.singularity/cache'
export SINGULARITY_TEMPDIR='$BASE_DIR/tmp'
export LD_LIBRARY_PATH='/global/software/sl-7.x86_64/modules/langs/gcc/12.1.0/lib64:${LD_LIBRARY_PATH}'
export WANDB_API_KEY='87928bf7ce62528545fe624701ab2f3aa25a7547'

BASE_DIR=/global/scratch/users/$USER
LDIR=$BASE_DIR/.local$SLURM_ARRAY_TASK_ID
LOGDIR_BASE=$BASE_DIR/logs
rm -rf $LDIR
mkdir -p $LDIR
SINGULARITY_IMAGE_LOCATION=/global/scratch/users/$USER
SINGULARITY_CACHEDIR=$BASE_DIR/.singularity/cache
export SINGULARITY_CACHEDIR=$BASE_DIR/.singularity/cache
SINGULARITY_TEMPDIR=$BASE_DIR/tmp
export SINGULARITY_TEMPDIR=$BASE_DIR/tmp
SINGULARITY_CACHEDIR=/global/scratch/users/$USER/transactive-control-social-game
PYTHON_DIR=/global/home/users/$USER/.conda/envs/ActiveRL/bin
PYTHON_PATH=/home/miniconda/envs/ActiveRL/bin/python
module load gcc
export LD_LIBRARY_PATH=/global/software/sl-7.x86_64/modules/langs/gcc/12.1.0/lib64:${LD_LIBRARY_PATH}
export WANDB_API_KEY=87928bf7ce62528545fe624701ab2f3aa25a7547
if test -f sinergym.sif; then
  echo “docker image exists”
else
  singularity pull --tmpdir=/global/scratch/users/$USER/tmp sinergym.sif docker://doseokjang/sinergym:savio
fi
singularity run --nv --workdir ./tmp --bind $(pwd):$HOME --bind "$LDIR:$HOME/.local" --bind "$PYTHON_DIR:/.env" sinergym.sif bash -c ". sbatch_scripts/singularity_preamble_new.sh && $PYTHON_PATH $1"
