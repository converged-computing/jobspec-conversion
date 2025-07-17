#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -c=8
#FLUX: --queue=cpu_p1
#FLUX: -t=36000
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'

set -x -e
source $six_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
CKPTS=(
iter_0035000
iter_0040000
iter_0045000
iter_0050000
)
EXAMPLE_CKPT=/gpfswork/rech/ajs/commun/code/bigcode/finetune/santacoderref
DUMP_PATH=/gpfswork/rech/ajs/commun/code/bigcode/finetune/santacoderlongconv
OUT_PREFIX=santacoderlong_
CKPT_PATH=/gpfswork/rech/ajs/commun/code/bigcode/finetune/santacoderlong
for i in {0..5}; do
CKPT=${CKPTS[$i]}
echo "$i"
echo "Running $CKPT"
OUTPUTCKPT=$DUMP_PATH/"$OUT_PREFIX$CKPT"
cd /gpfswork/rech/ajs/commun/code/bigcode/finetune/Megatron-LM
python -m tools.hf_transformers.convert_checkpoint --path_to_checkpoint $CKPT_PATH/$CKPT/mp_rank_00/model_optim_rng.pt --output-dir $OUTPUTCKPT
cp -r $EXAMPLE_CKPT/*.json $OUTPUTCKPT/
cp -r $EXAMPLE_CKPT/*.py $OUTPUTCKPT/
eval_script="./eval_$i.slurm"
cat <<EOT > $eval_script
source $ajs_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
conda activate bigcode
cd /gpfswork/rech/ajs/commun/code/bigcode/bigcode-evaluation-harness
accelerate launch --config_file config_1a100_fp16.yaml main.py \
--model $OUTPUTCKPT \
--tasks humaneval-x-bugs-python \
--do_sample False \
--n_samples 1 \
--batch_size 1 \
--allow_code_execution \
--save_generations \
--trust_remote_code \
--mutate_method edit \
--generations_path generations_humanevalxbugs_$OUT_PREFIX$CKPT\_greedy.json \
--output_path evaluation_results_humanevalxbugs_$OUT_PREFIX$CKPT\_greedy.json \
--max_length_generation 2048
EOT
sbatch $eval_script
done
