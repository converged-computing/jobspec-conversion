#!/bin/bash
#FLUX: --job-name=stable_diffusion
#FLUX: -c=40
#FLUX: -t=450000
#FLUX: --urgency=16

export PROMPT='${1:-""}'
export HEIGHT='${HEIGHT:-"256"}'
export WIDTH='${WIDTH:-"256"}'
export CFGSCALE='${CFGSCALE:-"7.5"}'
export N='${N:-"9"}'
export STEPS='${STEPS:-"100"}'

[ -z "$1" ] && { echo "Need to set prompt"; exit 1; }
export PROMPT=${1:-""}
export HEIGHT=${HEIGHT:-"256"}
export WIDTH=${WIDTH:-"256"}
export CFGSCALE=${CFGSCALE:-"7.5"}
export N=${N:-"9"}
export STEPS=${STEPS:-"100"}
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
docker build -t stablediffusion .
docker run --rm -t --init \
  --gpus="device=$CUDA_VISIBLE_DEVICES" \
  --ipc=host \
  --user="$(id -u):$(id -g)" \
  --volume="/dev/hugepages:/dev/hugepages" \
  --volume="$HOME/.netrc:/home/user/.netrc" \
  --volume="/work/paras/stable_diffusion_weights/sd-v1-3.ckpt:`pwd`/models/ldm/stable-diffusion-v1/model.ckpt" \
  --volume="`pwd`/results:/results" \
  --env="PYTHONPATH=/app" \
  stablediffusion python scripts/txt2img.py --prompt "$PROMPT" --plms --precision autocast --n_samples $N -H $HEIGHT -W $WIDTH --scale $CFGSCALE --ddim_steps $STEPS
