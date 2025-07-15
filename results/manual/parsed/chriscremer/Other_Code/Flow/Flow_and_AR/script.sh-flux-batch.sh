#!/bin/bash
#FLUX: --job-name=phat-butter-0454
#FLUX: --priority=16

export PATH='$PATH:/h/ccremer/anaconda3/bin'

export PATH=$PATH:/h/ccremer/anaconda3/bin
source activate test_env
python3 train5.py  --exp_name "flickr_oneimages_someflow" \
								--machine 'vws' \
								--which_gpu '0' \
								--dataset 'flickr' \
								--data_dir "$HOME/Documents/" \
								--save_to_dir "$HOME/Documents/glow_clevr/" \
								--batch_size 8 \
								--load_step 0 \
								--load_dir "$HOME/Documents/glow_clevr/FlowAR_clevr_test2/params/" \
								--print_every 100 \
								--curveplot_every 20000 \
								--plotimages_every 400 \
								--save_every 20000 \
								--max_steps 200000 \
								--n_levels 1 \
								--depth 12 \
								--hidden_channels 128 \
								--AR_resnets 5 \
								--AR_channels 32 \
								--coupling 'affine' \
								--permutation 'shuffle' \
								--base_dist 'AR' \
								--lr 1e-3 \
								--quick 1 \
								--save_output 0 \
								--dataset_size 2 \
