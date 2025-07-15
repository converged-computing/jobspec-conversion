#!/bin/bash
#FLUX: --job-name=myJob
#FLUX: --queue=gpu
#FLUX: --urgency=16

export PATH='$PATH:/h/ccremer/anaconda3/bin'

export PATH=$PATH:/h/ccremer/anaconda3/bin
source activate test_env
conda info --envs
python3 run_vae_cifar.py --exp_name "vae_test_gpu" \
								--z_size 384 --batch_size 64 \
								--enc_res_blocks 3 --dec_res_blocks 64 --n_prior_flows 25 \
								--which_gpu '0' \
								--data_dir "$HOME/Documents/" \
								--save_to_dir "$HOME/Documents/VAE2_exps/" \
								--display_step 500 --start_storing_data_step 2001 \
								--viz_steps 5000  --trainingplot_steps 5000 \
								--save_params_step 50000 --max_steps 400000 \
								--warmup_steps 20000 --continue_training 0 \
								--params_load_dir "$HOME/Documents/VAE2_exps/vae_test_prior_noperm/params/" \
								--model_load_step 0 \
								--save_output 1
source deactivate
