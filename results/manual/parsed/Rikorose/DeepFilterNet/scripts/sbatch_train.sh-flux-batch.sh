#!/bin/bash
#FLUX: --job-name=df
#FLUX: -t=86400
#FLUX: --urgency=16

export CLUSTER='/net/cluster/$USER'
export WORKON_HOME='/cluster/$USER/.cache'
export XDG_CACHE_DIR='/cluster/$USER/.cache'
export PYTHONUSERBASE='/cluster/$USER/.python_packages'
export HDF5_USE_FILE_LOCKING='FALSE'
export RUST_BACKTRACE='1'

set -e
export CLUSTER=/net/cluster/$USER
cd "$CLUSTER"
export WORKON_HOME="/cluster/$USER/.cache"
export XDG_CACHE_DIR="/cluster/$USER/.cache"
export PYTHONUSERBASE="/cluster/$USER/.python_packages"
export HDF5_USE_FILE_LOCKING='FALSE'
export RUST_BACKTRACE=1
PROJECT_NAME=DeepFilterNet
BRANCH=${BRANCH:-main}
DATA_DIR=${DATA_DIR:-$CLUSTER/Data/HDF5}     # Set to the directory containing the HDF5s
DATA_CFG=${DATA_CFG:-$DATA_DIR/datasets.cfg} # Default dataset configuration
DATA_CFG=$(readlink -f "$DATA_CFG")
PYTORCH_JIT=${PYTORCH_JIT:-1}                # Set to 0 to disable pytorch JIT compilation
COPY_DATA=${COPY_DATA:-1}                    # Copy data
COPY_MAX_GB=${COPY_MAX_GB:-150}              # Max amount to copy hdf5 datasets, rest will be linked
DEBUG=${DEBUG:-0}                            # Debug mode passed to the python train script
EXCLUDE=${EXCLUDE:-lme[49,170,171]}          # Slurm nodes to exclude
if [ "$DEBUG" -eq 1 ]; then
  DEBUG="--debug"
elif [ "$DEBUG" -eq 0 ]; then
  DEBUG="--no-debug"
fi
if [ "$DF_DISABLE_AUG" -eq 1 ]; then
  export DF_P_REMVOE_DC=0.0
  export DF_P_LFILT=0.0
  export DF_P_BIQUAD=0.0
  export DF_P_RESAMPLE=0.0
  export DF_P_CLIPPING=0.0
  export DF_P_CLIPPING_NOISE=0.0
  export DF_P_ZEROING=0.0
  export DF_P_AIR_AUG=0.0
  export DF_P_NOISE_GEN=0.0
fi
echo "Started sbatch script at $(date) in $(pwd)"
echo "Found cuda devices: $CUDA_VISIBLE_DEVICES"
nvidia-smi -L || echo "nvidia-smi not found"
echo "Running on host: $(hostname)"
if [[ -z $1 ]]; then
  echo >&2 "No model base directory provided!"
  exit
fi
if [[ ! -d $1 ]]; then
  echo >&2 "Model base directory not found at $1!"
  exit
fi
BASE_DIR=$(readlink -f "$1")
echo "Got base_dir: $BASE_DIR"
MODEL_NAME=$(basename "$BASE_DIR")
PROJECT_BRANCH=${BRANCH:-$PROJECT_BRANCH_CUR}
if [[ -n $2 ]]; then
  if [[ ! -d $2 ]]; then
    echo >&2 "Project home not found at $2!"
    exit
  fi
  PROJECT_HOME=$2
else
  PROJECT_ClUSTER_HOME=$CLUSTER/$PROJECT_NAME/
  PROJECT_HOME=$CLUSTER/sbatch-$PROJECT_NAME/$MODEL_NAME/
  mkdir -p "$PROJECT_HOME"
  echo "Copying repo to $PROJECT_HOME"
  cd "$PROJECT_ClUSTER_HOME"
  rsync -avq --include .git \
    --exclude-from="$(git -C "$PROJECT_ClUSTER_HOME" ls-files --exclude-standard -oi --directory >.git/ignores.tmp && echo .git/ignores.tmp)" \
    "$PROJECT_ClUSTER_HOME" "$PROJECT_HOME" --delete
fi
if [ -n "$3" ]; then
  # Checkout specified branch from previous job
  PROJECT_BRANCH_CUR=$3
else
  # Use current branch of project on /cluster
  PROJECT_BRANCH_CUR=$(git -C "$PROJECT_ClUSTER_HOME" rev-parse --abbrev-ref HEAD)
fi
echo "Running on branch $PROJECT_BRANCH in dir $PROJECT_HOME"
if [ "$PROJECT_BRANCH_CUR" != "$PROJECT_BRANCH" ]; then
  stash="stash_$SLURM_JOB_ID"
  git -C "$PROJECT_HOME" stash save "$stash"
  git -C "$PROJECT_HOME" checkout "$PROJECT_BRANCH"
  stash_idx=$(git -C "$PROJECT_HOME" stash list | grep "$stash" | cut -d: -f1)
  if [ -n "$stash_idx" ] && [ "$stash_idx" != " " ]; then
    # Try to apply current stash; If not possible just proceed.
    if ! git -C "$PROJECT_HOME" stash pop "$stash_idx"; then
      echo "Could not apply stash to branch $PROJECT_BRANCH"
      git -C "$PROJECT_HOME" checkout -f
    fi
  fi
fi
. "$PROJECT_HOME"/scripts/setup_env.sh --source-only
setup_env "$CLUSTER" "$PROJECT_HOME" "$MODEL_NAME"
if [[ -d /scratch ]] && [[ $COPY_DATA -eq 1 ]]; then
  test -d "/scratch/$USER" || mkdir "/scratch/$USER"
  NEW_DATA_DIR=/scratch/"$USER"/"$PROJECT_NAME"
  echo "Setting up data dir in $NEW_DATA_DIR"
  mkdir -p "$NEW_DATA_DIR"
  python3 "$PROJECT_HOME"/scripts/copy_datadir.py cp "$DATA_DIR" "$NEW_DATA_DIR" "$DATA_CFG" \
    --lock "$MODEL_NAME" --max-gb "$COPY_MAX_GB" --other-hosts
  DATA_DIR="$NEW_DATA_DIR"
fi
DS_SIZE=$(($(stat -f --format="%a*%S/1000/1000/1000" "$DATA_DIR")))
echo "Dataset directory size: $DS_SIZE"
du -hs "$DATA_DIR"
function _cleanup_scratch {
  echo "Checking if need to cleanup scratch: $NEW_DATA_DIR"
  if [[ -d /scratch ]] && [[ $COPY_DATA -eq 1 ]]; then
    python3 "$PROJECT_HOME"/scripts/copy_datadir.py cleanup "$NEW_DATA_DIR" --lock "$MODEL_NAME"
  fi
}
function _at_exit {
  conda deactivate
  # Check for return code if training was completed
  echo "Checking if need to resubmit training script"
  python3 "$PROJECT_HOME"/scripts/has_continue_file.py "$BASE_DIR"
  retVal=$?
  if [ $retVal -eq 0 ]; then
    echo "Training not completed. Resubmitting to continue training."
    sh -c "sbatch --exclude=$EXCLUDE \
      --job-name=$SLURM_JOB_NAME \
      $PROJECT_HOME/scripts/sbatch_train.sh $BASE_DIR $PROJECT_HOME $PROJECT_BRANCH"
    exit 0
  fi
  _cleanup_scratch
}
trap _at_exit EXIT
trap _cleanup_scratch ERR
function _usr1 {
  echo "Caught SIGUSR1 signal!"
  kill -USR1 "$trainprocess" 2>/dev/null
  wait "$trainprocess"
}
trap _usr1 SIGUSR1
cd "$PROJECT_HOME"/DeepFilterNet/df/
printf "\n***Starting training***\n\n"
PYTHONPATH="$PROJECT_HOME/DeepFilterNet/" python train.py \
  --host-batchsize-config $CLUSTER/host_batchsize.ini \
  "$DATA_CFG" \
  "$DATA_DIR" \
  "$BASE_DIR" \
  "$DEBUG" &
trainprocess=$!
echo "Started trainprocess: $trainprocess"
wait $trainprocess
echo "Training stopped"
