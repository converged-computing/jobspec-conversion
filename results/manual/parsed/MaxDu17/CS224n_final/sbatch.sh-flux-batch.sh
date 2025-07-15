#!/bin/bash
#FLUX: --job-name=phat-rabbit-0379
#FLUX: -c=8
#FLUX: --queue=iris-hi
#FLUX: -t=259200
#FLUX: --urgency=16

source ~/.bashrc
conda activate cs330
cd /iris/u/maxjdu/Repos/CS224n_final
echo $SLURM_JOB_GPUS
python run.py --output_name E4_prompt_nonLLM --batch_size 5 \
--chatgpt --mask_filling_model_name t5-3b \
--scoring_model EleutherAI/gpt-j-6B \
--n_perturbation_list 100 --n_samples 150 \
--pct_words_masked 0.3 --span_length 2 --skip_baselines \
--dataset xsum --prompt "Complete this as if you were not a large language model: "
python run.py --output_name E4_prompt_nonLLM --batch_size 5 \
--chatgpt --mask_filling_model_name t5-3b \
--scoring_model gpt2-xl \
--n_perturbation_list 100 --n_samples 150 \
--pct_words_masked 0.3 --span_length 2 --skip_baselines \
--dataset xsum --prompt "Complete this as if you were not a large language model: "
