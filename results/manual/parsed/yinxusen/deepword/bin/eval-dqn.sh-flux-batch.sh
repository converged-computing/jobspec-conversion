#!/bin/bash
#FLUX: --job-name=chocolate-peas-3175
#FLUX: -n=4
#FLUX: --queue=isi
#FLUX: -t=360000
#FLUX: --urgency=16

set -e -x
echo "SLURM_JOBID=$SLURM_JOBID"
echo "SLURM_JOBNAME=$SLURM_JOB_NAME"
echo "SLURM_JOB_NODELIST=$SLURM_JOB_NODELIST"
echo "SLURM_NNODES=$SLURM_NNODES"
echo "SLURMTMPDIR=$SLURMTMPDIR"
echo "working directory=$SLURM_SUBMIT_DIR"
if [[ $(hostname) =~ "hpc" ]]; then
    PDIR="$SLURM_SUBMIT_DIR"
    filename="$SLURM_JOB_NAME"
    extension="${filename##*.}"
    filename="${filename%.*}"
    export PYENV_ROOT="$HOME/local/lib/pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi
    eval "$(pyenv virtualenv-init -)"
    pyenv activate deepdnd-drrn
else
    FWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    PDIR="$FWDIR/.."
    filename=$(basename "$0")
    extension="${filename##*.}"
    filename="${filename%.*}"
fi
if [[ -f $HOME/local/etc/init_tensorflow.sh ]]; then
    # shellcheck source=/dev/null
    source "$HOME/local/etc/init_tensorflow.sh"
fi
MODELHOME=$1
GAMEPATH=$2
pushd "$PDIR"
./sbin/run.sh python/deepword/main.py \
    --agent-clazz "CompetitionAgent" \
    --policy-to-action "LinUCB" \
    --model-dir "$MODELHOME" \
    eval-dqn \
    --game-path "$GAMEPATH" \
    --load-best
popd
