#!/bin/bash
#FLUX: --job-name=expensive-knife-8262
#FLUX: --queue=gpu
#FLUX: -t=43195
#FLUX: --urgency=16

set -eu -o pipefail
fol=$1          # checkpoint folder - or name of language model: e.g. model/checkpoint-10000/ or xlm-roberta-large
save_fol=$2     # folder where we save results
config=$3       # config file with settings
lang=$4         # language
model_type=$5   # e.g. roberta or xlmroberta
task=$6         # the task we are doing: upos, xpos or ner
mkdir -p $save_fol
basename=$(basename $fol)
base_config=$(basename $config)
config_name="${base_config%.*}"
fol_name=$(basename "$(dirname $fol)")
exp_name="${lang}_${fol_name}_${basename}_${config_name}"
if [[ $task == "upos" || $task == "xpos" ]] ; then
    data_fol="data/${lang}_POS/"
elif [[ $task == "ner" ]] ; then
    data_fol="data/${lang}_NER/"
else
    echo "Task not found, must be upos, xpos or ner, exit"
    exit -1
fi
train="${data_fol}/train.${task}.conll"
dev="${data_fol}/dev.${task}.conll"
test="${data_fol}/test.${task}.conll"
seeds=(2222 3333 4444 5555 6666)
START=1
END=3
echo "Start run $START, end run $END"
let "idx = $START -1" || true
for run in $(eval echo "{$START..$END}"); do
    # Set the correct seed for this run and increase counter
    CUR_SEED=${seeds[$idx]}
    let "idx=$idx+1"
    # Set names of output files
    out_file="${exp_name}_${task}_run${run}.eval"
    # Set output directories to save training info
    out_dir="${save_fol}/${exp_name}_${task}_run${run}"
    # Only do the training if output files do not exist yet
    if [[ ! -f ${save_fol}/$out_file ]] ; then
        echo "Currently at run $run/$END for $task for $lang"
        python src/finetune.py --train_file $train -o $out_dir --test_files $dev $test -a $config -lt $model_type -li $fol --seed $CUR_SEED > ${save_fol}/$out_file
		# Remove the model after training to save space
		rm ${out_dir}/pytorch_model.bin || true
    else
        echo "Skip $task for $fol - out file already exists"
    fi
done
python src/average_scores.py -f $save_fol -p ${exp_name}_${task} -o ${save_fol}/${exp_name}_${task}_avg.eval
