#!/bin/bash
#FLUX: --job-name=timing
#FLUX: --queue=cook,free_gpu,cahnrs_gpu,kamiak
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

. kamiak_config.sh
. kamiak_tensorflow_gpu.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
handle_terminate() { echo "Exiting"; exit 1; }
handle_error() { echo "Error occured -- exiting"; exit 1; }
trap "handle_terminate" SIGTERM SIGINT
suffix=$1; shift
[[ -z $suffix ]] && { echo "no suffix specified"; handle_error; }
methods=("vrada" "rdann" "daws" "dann" "none")
debugnums=(1 2 3)
uids=(0 1 2)
datasets=("ucihar" "uwave" "ucihhar")
sources=("2" "2" "1")
targets=("11" "5" "3")
correct_min=0
correct_max=$(( ${#methods[@]} * ${#debugnums[@]} * ${#sources[@]} - 1))
[[ ${#sources[@]} == ${#targets[@]} ]] || \
    { echo "source/target sizes should match"; handle_error; }
[[ ${#sources[@]} == ${#uids[@]} ]] || \
    { echo "length of sources and uids arrays differ"; handle_error; }
[[ ${#sources[@]} == ${#datasets[@]} ]] || \
    { echo "length of sources and datasets arrays differ"; handle_error; }
index=$SLURM_ARRAY_TASK_ID
index1max=${#sources[@]}
index2max=${#debugnums[@]}
index3=$((index / (index1max * index2max)))
index=$((index - index3 * index1max * index2max))
index2=$((index / index1max))
index1=$((index % index1max))
method="${methods[$index3]}"
debugnum="${debugnums[$index2]}"
uid="${uids[$index1]}"
dataset_name="${datasets[$index1]}"
source="${sources[$index1]}"
target="${targets[$index1]}"
echo "$suffix;$method;$dataset_name;$source;$target;$uid;$debugnum;$SLURM_ARRAY_TASK_ID"
additional_args=()
if [[ $method == "upper" ]]; then
    method="none"
    source="$target"
    target=""
fi
additional_args+=("--time_training")
cd "$remotedir"
python3 main.py \
    --logdir="$logFolder-$suffix" --modeldir="$modelFolder-$suffix" \
    --method="$method" --dataset="$dataset_name" --sources="$source" \
    --target="$target" --uid="$uid" --debugnum="$debugnum" \
    --gpumem=0 "${additional_args[@]}" "$@" || handle_error
