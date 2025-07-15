#!/bin/bash
#FLUX: --job-name=cfq_wandb
#FLUX: -c=40
#FLUX: -t=450000
#FLUX: --priority=16

export NJOBS='${NJOBS:-4}'
export CFQ_DIR='data/cfq'
export DATA_CACHE='/data/$USER/data_cache/cfq'

export NJOBS=${NJOBS:-4}
[ -z "$SWEEPID" ] && { echo "Need to set SWEEPID"; exit 1; }
export CFQ_DIR="data/cfq"
export DATA_CACHE="/data/$USER/data_cache/cfq"
[[ -d $CFQ_DIR ]] || (python scripts/download_cfq.py --data_dir $CFQ_DIR)
mkdir -p $DATA_CACHE
chmod 755 $DATA_CACHE
rsync -avhW --no-compress --progress $CFQ_DIR $DATA_CACHE
function docker() {
    case "$1" in
        run)
            shift
            if [ -t 1 ]; then # have tty
                command docker run --init -it "$@"
            else
                id=`command docker run -d --init "$@"`
                trap "command docker kill $id" INT TERM SIGINT SIGTERM
                command docker logs --follow $id
            fi
            ;;
        *)
            command docker "$@"
    esac
}
set -x
docker build -t cfq .
docker run --rm -t --init \
  --gpus="device=$CUDA_VISIBLE_DEVICES" \
  --ipc=host \
  --user="$(id -u):$(id -g)" \
  --volume="/dev/hugepages:/dev/hugepages" \
  --volume="$DATA_CACHE:/app/data" \
  --volume="$HOME/.netrc:/home/user/.netrc" \
  --env="PYTHONPATH=/app" \
  cfq wandb agent --count $NJOBS $SWEEPID
