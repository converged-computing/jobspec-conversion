#!/bin/bash
#FLUX: --job-name=mml-pgg-off-sim
#FLUX: -c=3
#FLUX: -t=240
#FLUX: --urgency=16

export NCCL_BLOCKING_WAIT='1  #Set this environment variable if you wish to use the NCCL backend for inter-GPU communication.'
export MASTER_ADDR='$(hostname) #Store the master node’s IP address in the MASTER_ADDR environment variable.'

seeds=(12321 943 111 300 1300)
gpu_ids=(0 0 0 0 0)
steps=(7700 5900 11000 10700 15200)
for i in ${!seeds[@]};
do
    cuda_gpu=${gpu_ids[$i]}
    seed=${seeds[$i]}
	step=${steps[$i]}
    CUDA_VISIBLE_DEVICES=${cuda_gpu} python3.7 src/re_gold_qa_train.py \
		--mode fewrl_test \
		--model_path ~/sep-1/fewrel/run_${seed}_with_unks/ \
		--answer_checkpoint _0_answer_step_${step} \
		--question_checkpoint _0_question_step_${step} \
		--num_search_samples 8 \
		--batch_size 128 \
		--gpu True \
		--train ./fewrl_data_unks/train_data_${seed}.csv \
		--dev  ./fewrl_data_unks/val_data_${seed}.csv \
		--test  ./fewrl_data_unks/test_data_${seed}.csv \
		--gpu_device 0 \
		--predict_type relation \
		--prediction_file ~/sep-1/fewrel/run_${seed}_with_unks/relation.offmml-pgg.run.epoch.0.test.predictions.step.${step}.csv \
		--seed ${seed}
done
'''
seeds=(12321 943 111 300 1300)
gpu_ids=(0 0 0 0 0)
steps=(7700 5900 11000 10700 15200)
for i in ${!seeds[@]};
do
    cuda_gpu=${gpu_ids[$i]}
    seed=${seeds[$i]}
    CUDA_VISIBLE_DEVICES=${cuda_gpu} python3.7 src/re_gold_qa_train.py \
		--mode multi_fewrl_dev \
		--model_path ~/sep-1/fewrel/run_${seed}_with_unks/ \
		--answer_checkpoint _response_pretrained \
		--question_checkpoint _fold_1_question_pretrained \
		--learning_rate 0.0005 \
		--training_steps 2500 \
		--start_epoch 0 \
		--end_epoch 0 \
		--start_step 100 \
		--end_step 2500 \
		--step_up 100 \
		--max_epochs 1 \
		--num_search_samples 8 \
		--batch_size 128 \
		--gpu True \
		--train ./fewrl_data_unks/train_data_${seed}.csv \
		--dev  ./fewrl_data_unks/val_data_${seed}.csv \
		--test  ./fewrl_data_unks/test_data_${seed}.csv \
		--gpu_device 0 \
		--predict_type relation \
		--seed ${seed}
done
steps=(7700 5900 11000 10700 15200)
for i in ${!seeds[@]};
do
	cuda_gpu=${gpu_ids[$i]}
    seed=${seeds[$i]}
    step=${steps[$i]}
    CUDA_VISIBLE_DEVICES=${cuda_gpu} python3.7 src/re_gold_qa_train.py \
        --mode fewrl_train \
		--model_path ~/sep-1/fewrel/run_${seed}_with_unks/ \
		--answer_checkpoint _0_answer_step_${step} \
		--question_checkpoint _0_question_step_${step} \
		--num_search_samples 8 \
		--learning_rate 0.0005 \
		--training_steps 2500 \
		--max_epochs 1\
		--batch_size 4 \
		--gpu True \
		--train ~/codes/RelationPrompt/trained-fewrel-models/run_${seed}/synthetic_train.csv \
		--dev  ~/QA-ZRE/fewrl_data_unks/val_data_${seed}.csv \
		--test  ~/QA-ZRE/fewrl_data_unks/test_data_${seed}.csv \
		--gpu_device 0 \
		--seed ${seed} \
		--train_method MML-PGG-Off-Sim &
done
for (( i=12; i<=12; i++ ))
do
	for (( e=0; e<=0; e++ ))
	do
		step=$((i * 200))
		printf "step ${step} on epoch ${e}\r\n"
		CUDA_VISIBLE_DEVICES=0 python3.7 src/re_gold_qa_train.py \
			--mode fewrl_test \
			--model_path ~/june-16/fewrl/run_5/ \
			--answer_checkpoint _${e}_answer_step_${step} \
			--question_checkpoint _${e}_question_step_${step} \
			--training_steps 2600 \
			--learning_rate 0.0005 \
			--max_epochs 1 \
			--num_search_samples 8 \
			--batch_size 32 --gpu True \
			--ignore_unknowns True \
			--train ./small_fewrl_data/train_data_1300.csv \
			--dev ./small_fewrl_data/val_data_1300.csv \
			--test ./small_fewrl_data/test_data_1300.csv \
			--gpu_device 0 \
			--seed 1300 \
			--prediction_file ~/june-16/fewrl/run_5/relation.mml-pgg-off-sim.run.${e}.test.predictions.step.${step}.csv \
			--predict_type relation
	done
done
CUDA_VISIBLE_DEVICES=1 python src/re_gold_qa_train.py \
    --mode concat_fewrl_train \
    --model_path ~/concat_run_2/ \
    --checkpoint _response_pretrained_model \
    --training_steps 2600 \
    --learning_rate 0.0005 \
    --max_epochs 4 \
    --num_search_samples 8 \
    --batch_size 16 \
    --gpu True \
    --num_workers 3 \
    --train ./fewrl_data/train_data_943.csv \
    --dev ./fewrl_data/val_data_943.csv \
    --test ./fewrl_data/test_data_943.csv \
    --gpu_device 0 \
    --seed 943 \
module load StdEnv/2020 gcc/9.3.0 cuda/11.4 arrow/5.0.0
source ../dreamscape-qa/env/bin/activate
export NCCL_BLOCKING_WAIT=1  #Set this environment variable if you wish to use the NCCL backend for inter-GPU communication.
export MASTER_ADDR=$(hostname) #Store the master node’s IP address in the MASTER_ADDR environment variable.
echo "r$SLURM_NODEID master: $MASTER_ADDR"
echo "r$SLURM_NODEID Launching python script"
echo "All the allocated nodes: $SLURM_JOB_NODELIST"
steps=(4700 400 3600 800 7900 700 2100 6800 4300 1600)
for i in ${!steps[@]};
do
	fold_num=$((i+1))
	fold_data_id=$((fold_num-1))
	step=${steps[$i]}
	CUDA_VISIBLE_DEVICES=3 python3.7 src/re_gold_qa_train.py \
		--mode reqa_mml_eval \
		--model_path ~/may-20/fold_${fold_num}/ \
		--answer_checkpoint _0_answer_step_${step} \
		--question_checkpoint _0_question_step_${step} \
		--num_search_samples 8 \
		--batch_size 64 \
		--gpu True \
		--test ./zero-shot-extraction/relation_splits/test.${fold_data_id} \
		--gpu_device 0 \
		--seed 12321 \
		--prediction_file ~/may-20/fold_${fold_num}/relation.mml-pgg-off-sim.run.fold_${fold_num}.test.predictions.step.${step}.csv \
		--predict_type relation
done
'''
