#!/bin/bash
#FLUX: --job-name=eval
#FLUX: --queue=cook,free_gpu,cahnrs_gpu,kamiak
#FLUX: -t=3600
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
variants=("best_source")
uids=(u0 u1 u2 u3 u4 u5_0 u5_3 u5_4 u0 u1 u4 u5_0 u5_3 u0 u1 u2 u3 u0 u1 u2 u3 u4 u5_0 u5_1 u5_3 u0 u1 u2 u3 u4 u5_0 u5_1 u5_2 u5_3 u0 u1 u2 u3 u4 u5_0 u5_2 u5_3 u5_4)
datasets=("ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "uwave" "uwave" "uwave" "uwave" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at")
sources=("" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "")
targets=("19" "16" "23" "25" "24" "18" "11" "13" "3" "6" "8" "7" "5" "5" "7" "6" "8" "12" "8" "4" "11" "13" "14" "3" "15" "11" "31" "29" "25" "8" "32" "15" "7" "30" "44" "13" "46" "43" "23" "16" "33" "38" "20")
correct_min=0
correct_max=$(( ${#methods[@]} * ${#variants[@]} * ${#sources[@]} - 1))
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
index2max=${#variants[@]}
index3=$((index / (index1max * index2max)))
index=$((index - index3 * index1max * index2max))
index2=$((index / index1max))
index1=$((index % index1max))
method="${methods[$index3]}"
variant="${variants[$index2]}"
uid="${uids[$index1]}"
dataset_name="${datasets[$index1]}"
source="${sources[$index1]}"
target="${targets[$index1]}"
out="results/results_${suffix}_$variant-$dataset_name-$uid-$method.yaml"
additional_args=()
if [[ $method == "upper" ]]; then
    method="none"
    source="$target"
    target=""
fi
echo "$suffix #$SLURM_ARRAY_TASK_ID"
echo "Selection: $variant"
echo "Method: $method"
echo "Other args: $@"
echo "UID: $uid"
echo "$dataset_name $source --> $target"
cd "$remotedir"
mkdir -p results
python3 main_eval.py \
    --logdir="$logFolder-$suffix" --modeldir="$modelFolder-$suffix" \
    --jobs=1 --gpus=1 --gpumem=0 \
    --match="${dataset_name}-${uid}-${method}-[0-9]*" \
    --selection="$variant" --output_file="$out" \
    "${additional_args[@]}" "$@" || handle_error
