#!/bin/bash
#FLUX: --job-name=train
#FLUX: --queue=cook,free_gpu,cahnrs_gpu,kamiak
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

. kamiak_config.sh
. kamiak_tensorflow_gpu.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
handle_terminate() { echo "Exiting"; exit 1; }
handle_error() { echo "Error occurred -- exiting"; exit 1; }
trap "handle_terminate" SIGTERM SIGINT
suffix=$1; shift
[[ -z $suffix ]] && { echo "no suffix specified"; handle_error; }
methods=("upper")
debugnums=(1 2 3)
uids=(u0 u1 u2 u3 u4 u5_0 u5_3 u5_4 u0 u1 u4 u5_0 u5_3 u0 u1 u2 u3 u0 u1 u2 u3 u4 u5_0 u5_1 u5_3 u0 u1 u2 u3 u4 u5_0 u5_1 u5_2 u5_3 u0 u1 u2 u3 u4 u5_0 u5_2 u5_3 u5_4)
datasets=("ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "uwave" "uwave" "uwave" "uwave" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at")
sources=("" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "")
targets=("19" "16" "23" "25" "24" "18" "11" "13" "3" "6" "8" "7" "5" "5" "7" "6" "8" "12" "8" "4" "11" "13" "14" "3" "15" "11" "31" "29" "25" "8" "32" "15" "7" "30" "44" "13" "46" "43" "23" "16" "33" "38" "20")
correct_min=0
correct_max=$(( ${#methods[@]} * ${#debugnums[@]} * ${#sources[@]} - 1))
[[ ${#sources[@]} == ${#targets[@]} ]] || \
    { echo "source/target sizes should match"; handle_error; }
[[ ${#sources[@]} == ${#uids[@]} ]] || \
    { echo "length of sources and uids arrays differ"; handle_error; }
[[ ${#sources[@]} == ${#datasets[@]} ]] || \
    { echo "length of sources and datasets arrays differ"; handle_error; }
[[ $SLURM_ARRAY_TASK_MIN == $correct_min ]] || \
    { echo "array min should be $correct_min"; handle_error; }
[[ $SLURM_ARRAY_TASK_MAX == $correct_max ]] || \
    { echo "array max should be $correct_max"; handle_error; }
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
additional_args=()
if [[ $method == "upper" ]]; then
    method="none"
    source="$target"
    target=""
fi
if [[ $method == "random" ]]; then
    additional_args+=("--log_val_steps=100")
fi
echo "$suffix #$SLURM_ARRAY_TASK_ID"
echo "Method: $method"
echo "DebugNum: $debugnum"
echo "Other args: $@"
echo "UID: $uid"
echo "$dataset_name $source --> $target"
cd "$remotedir"
python3 main.py \
    --logdir="$logFolder-$suffix" --modeldir="$modelFolder-$suffix" \
    --method="$method" --dataset="$dataset_name" --sources="$source" \
    --target="$target" --uid="$uid" --debugnum="$debugnum" \
    --gpumem=0 "${additional_args[@]}" "$@" || handle_error
