#!/bin/bash
#FLUX: --job-name=nf_test
#FLUX: --urgency=16

hostname
whoami
python3 train_noise_flow.py --logdir noise_flow_model   --arch "sdn5|unc|unc|unc|unc|gain4|unc|unc|unc|unc" \
     --sidd_path './data/SIDD_Medium_Raw/Data' --n_train_threads 16   \
     --width 4 --epochs 2000  --lr 1e-4 --n_batch_train 138 --n_batch_test 138 --epochs_full_valid 10 \
     --n_patches_per_image 2898 --patch_height 32 --patch_sampling uniform \
     --start_tr_im_idx 10   --end_tr_im_idx 12   --start_ts_im_idx 10   --end_ts_im_idx 12
python3 train_noise_flow.py --logdir S-Ax1-G-Ax1-CAM   --arch "sdn5|unc|gain4|unc" \
     --sidd_path './data/SIDD_Medium_Raw/Data' --cam IP --iso 800  --n_train_threads 16   \
     --width 4 --epochs 2000  --lr 1e-4 --n_batch_train 138 --n_batch_test 138 --epochs_full_valid 10 \
     --n_patches_per_image 2898 --patch_height 32 --patch_sampling uniform \
     --start_tr_im_idx 10   --end_tr_im_idx 12   --start_ts_im_idx 10   --end_ts_im_idx 12
python3 train_noise_flow.py --logdir S-G-CAM   --arch "sdn5|gain4" \
     --sidd_path './data/SIDD_Medium_Raw/Data' --cam IP --iso 800 --n_train_threads 16   \
     --width 4 --epochs 2000  --lr 1e-4 --n_batch_train 138 --n_batch_test 138 --epochs_full_valid 10 \
     --n_patches_per_image 2898 --patch_height 32 --patch_sampling uniform \
     --start_tr_im_idx 10   --end_tr_im_idx 12   --start_ts_im_idx 10   --end_ts_im_idx 12
python3 train_noise_flow.py --logdir S-G   --arch "sdn4|gain4" \
     --sidd_path './data/SIDD_Medium_Raw/Data' --cam IP --iso 800 --n_train_threads 16   \
     --width 4 --epochs 2000  --lr 1e-4 --n_batch_train 138 --n_batch_test 138 --epochs_full_valid 10 \
     --n_patches_per_image 2898 --patch_height 32 --patch_sampling uniform \
     --start_tr_im_idx 10   --end_tr_im_idx 12   --start_ts_im_idx 10   --end_ts_im_idx 12
python3 train_noise_flow.py --logdir Ax4   --arch "unc|unc|unc|unc" \
     --sidd_path './data/SIDD_Medium_Raw/Data' --cam IP --iso 800 --n_train_threads 16   \
     --width 4 --epochs 2000  --lr 1e-4 --n_batch_train 138 --n_batch_test 138 --epochs_full_valid 10 \
     --n_patches_per_image 2898 --patch_height 32 --patch_sampling uniform \
     --start_tr_im_idx 10   --end_tr_im_idx 12   --start_ts_im_idx 10   --end_ts_im_idx 12
