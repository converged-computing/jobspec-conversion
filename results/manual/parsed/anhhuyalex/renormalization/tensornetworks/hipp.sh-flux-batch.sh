#!/bin/bash
#FLUX: --job-name=hipp_test
#FLUX: -t=86400
#FLUX: --priority=16

source activate renormalization
i_vals=(0.0 0.005 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 0.99) # len 30
j_vals=(500 1000 10000 20000 30000 40000 50000 60000) # 6
i=${i_vals[$SLURM_ARRAY_TASK_ID / ${#j_vals[@]}]}
j=${j_vals[$SLURM_ARRAY_TASK_ID % ${#j_vals[@]}]}
echo "SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID, i = $i, j = $j"
for k in 1 3 5 7 9 11 13 15 17; do python -u mnist_classification_shuffled_svd.py --data mnist --fileprefix sklearnlbfgs_gaussianshuffledsvd_highsignal_mnist_doinversetransform_randominit_MAY02_wd_$1 --optimizer_type sklearn_lbfgs --is_random_init True --lr 0.001 --lr_scheduler OneCycleLR --multiclass_lr   -b 500  --num_train_samples $j  --wd $1 --is_high_signal_to_noise True --is_shuffle_signal Gaussian --is_inverse_transform True --highsignal_pca_components_kept $i --save_dir /scratch/qanguyen/imagenet_info; done
