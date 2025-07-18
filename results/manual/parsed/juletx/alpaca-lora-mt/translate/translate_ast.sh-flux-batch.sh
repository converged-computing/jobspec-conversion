#!/bin/bash
#FLUX: --job-name=alpaca_ast
#FLUX: -c=8
#FLUX: --urgency=16

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export TOKENIZERS_PARALLELISM='true'
export OMP_NUM_THREADS='16'
export PMI_SIZE='1'
export OMPI_COMM_WORLD_SIZE='1'
export MV2_COMM_WORLD_SIZE='1'
export WORLD_SIZE='1'
export TRANSFORMERS_NO_ADVISORY_WARNINGS='true'
export PATH='/ikerlariak/igarcia945/pytorch-build/openmpi/lib:$PATH'
export LD_LIBRARY_PATH='/ikerlariak/igarcia945/pytorch-build/openmpi/lib:$LD_LIBRARY_PATH'

source /ikerlariak/igarcia945/envs/pytorch-tximista/bin/activate
cd /ikerlariak/igarcia945/Easy-Translate || exit
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TOKENIZERS_PARALLELISM=true
export OMP_NUM_THREADS=16
export PMI_SIZE=1
export OMPI_COMM_WORLD_SIZE=1
export MV2_COMM_WORLD_SIZE=1
export WORLD_SIZE=1
export TRANSFORMERS_NO_ADVISORY_WARNINGS="true"
export PATH="/ikerlariak/igarcia945/pytorch-build/openmpi/bin:$PATH"
export PATH="/ikerlariak/igarcia945/pytorch-build/openmpi/lib:$PATH"
export LD_LIBRARY_PATH="/ikerlariak/igarcia945/pytorch-build/openmpi/lib:$LD_LIBRARY_PATH"
for lang in ast_Latn
do
accelerate launch --mixed_precision fp16 translate.py \
--sentences_path /ikerlariak/igarcia945/alpaca-lora-mt/data/en.sentences.txt \
--output_path /ikerlariak/igarcia945/alpaca-lora-mt/data/"$lang".sentences.txt \
--source_lang eng_Latn \
--target_lang "$lang" \
--model_name facebook/nllb-200-3.3B \
--max_length 516 \
--num_beams 3 \
--num_return_sequences 1 \
--precision fp16
done
