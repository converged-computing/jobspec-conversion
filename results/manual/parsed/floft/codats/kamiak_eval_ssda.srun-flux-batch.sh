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
methods=("vrada" "rdann" "daws" "dann" "none")
variants=("best_target")
uids=(0 1 2 3 4 5_0 5_1 5_2 5_3 5_4 0 1 2 3 4 5_0 5_1 5_2 5_3 5_4 0 1 2 3 4 5_0 5_1 5_2 5_3 5_4 0 1 2 3 4 5_0 5_1 5_2 5_3 5_4 0 1 2 3 4 5_0 5_1 5_2 5_3 5_4 0 1 2 3 4 5_0 5_1 5_2 5_3 5_4)
datasets=("ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "ucihar" "uwave" "uwave" "uwave" "uwave" "uwave" "uwave" "uwave" "uwave" "uwave" "uwave" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "ucihhar" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_at" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "wisdm_ar" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother" "watch_noother")
sources=("14" "12" "18" "17" "7" "9" "12" "6" "2" "7" "4" "3" "2" "4" "7" "1" "1" "2" "3" "2" "1" "1" "0" "4" "5" "2" "5" "3" "3" "4" "26" "4" "45" "5" "9" "0" "38" "24" "20" "11" "3" "21" "25" "2" "0" "2" "4" "1" "7" "1" "6" "4" "2" "1" "12" "5" "1" "7" "7" "8")
targets=("19" "16" "23" "25" "24" "18" "18" "23" "11" "13" "5" "7" "6" "8" "8" "8" "7" "7" "5" "5" "3" "6" "6" "6" "8" "7" "6" "8" "5" "5" "44" "13" "46" "43" "23" "16" "46" "33" "38" "20" "11" "31" "29" "25" "8" "32" "15" "7" "30" "11" "12" "8" "4" "11" "13" "14" "3" "12" "15" "14")
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
