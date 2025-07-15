#!/bin/bash
#FLUX: --job-name=example
#FLUX: -c=10
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --priority=16

set -euo pipefail
module purge
module load tensorflow/2.2-hvd
source tf2.2-transformers3.4/bin/activate
batch_size=16
learning_rate="4e-5"
epochs=4
max_seq_length=256
model="./models/monologg/biobert_v1.1_pubmed/"
grid="false"
for i in "$@"
do
case $i in
    -g=*|--grid=*)
    grid="${i#*=}"
    shift
    ;;
    -bs=*|--batch_size=*)
    batch_size="${i#*=}"
    shift # past argument=value
    ;;
    -lr=*|--learning_rate=*)
    learning_rate="${i#*=}"
    shift # past argument=value
    ;;
    -e=*|--epochs=*)
    epochs="${i#*=}"
    shift # past argument=value
    ;;
    -msl=*|--max_seq_length=*)
    max_seq_length="${i#*=}"
    shift # past argument=value
    ;;
    -m=*|--model=*)
    model="${i#*=}"
    shift # past argument=value
    ;;
    -lr=*|--learning_rate=*)
    learning_rate="${i#*=}"
    shift # past argument=value
    ;;
    -d=*|--data_dir=*)
    data_dir="${i#*=}"
    shift # past argument=value
    ;;
    -od=*|--output_dir=*)
    output_dir="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done
if [ $grid == "false" ]; then
  rm -f latest.out latest.err
  ln -s logs/$SLURM_JOBID.out latest.out
  ln -s logs/$SLURM_JOBID.err latest.err
fi
SAVE_STEPS=0
SEED=1
labels=$data_dir"labels.txt"
echo "Using the following parameters"
echo "#############################"
echo "batch size: $batch_size"
echo "maximum sequence length: $max_seq_length"
echo "epochs: $epochs"
echo "data: $data_dir"
echo "labels: $labels"
echo "model: $model"
echo "learning rate: $learning_rate"
echo "output dir: $output_dir"
echo "savesteps: $SAVE_STEPS"
echo "seed: $SEED"
if [ -f test.log ]; then
 rm test.log
fi
if [ -f test_utils_ner.log ]; then
 rm test_utils_ner.log
fi
if [ ! -f "$labels" ]; then
  echo "$labels not found"
  exit 1
fi
echo "Running python program"
python3 run_tf_ner.py --data_dir $data_dir \
--labels $labels \
--model_name_or_path $model \
--output_dir $output_dir \
--max_seq_length  $max_seq_length \
--num_train_epochs $epochs \
--per_device_train_batch_size $batch_size \
--save_steps $SAVE_STEPS \
--seed $SEED \
--do_train \
--do_eval \
--do_predict \
--overwrite_output_dir \
--learning_rate $learning_rate \
