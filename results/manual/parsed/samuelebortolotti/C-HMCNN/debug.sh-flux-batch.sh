#!/bin/bash
#FLUX: --job-name=expensive-fudge-7180
#FLUX: --queue=chaos
#FLUX: -t=72000
#FLUX: --urgency=16

usage() {
  test $# = 0 || echo "$@"
  echo
  echo Trains and evaluates the network on the gpu cluster
  echo Options:
  echo "  -h, --help                    Print this help"
  echo
  exit 1
}
args=
while [ $# != 0 ]; do
  case $1 in
    -h|--help) usage ;;
    -?*) usage "Unknown option: $1" ;;
    *) args="$args \"$1\"" ;;
  esac
  shift
done
eval "set -- $args"
cd "/nfs/data_chaos/sbortolotti/code/C-HMCNN"
python="/nfs/data_chaos/sbortolotti/pkgs/miniconda/envs/chmncc/bin/python"
wandb="/nfs/data_chaos/sbortolotti/pkgs/miniconda/envs/chmncc/bin/wandb"
$wandb login $KEY
trap "trap ' ' TERM INT; kill -TERM 0; wait" TERM INT
${python} -m chmncc debug --learning-rate 0.001 --batch-size 128 --test-batch-size 256 --device "cuda" --project chmncc --wandb true --network "resnet"
wait
