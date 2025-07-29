#!/bin/bash
#FLUX: --job-name=vecBNCoGenT
#FLUX: --queue=normal
#FLUX: -t=540000
#FLUX: --urgency=16

module add openmind/singularity/3.4.1
hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
cd /om2/user/vanessad/understanding_reasoning/CLOSURE-master
singularity exec -B /om2:/om2 --nv /om/user/xboix/singularity/xboix-tensorflow2.5.0.simg python3 \
-m scripts.train_model \
--model_type EE \
--num_iterations 500000 \
--num_val_samples 100000 \
--load_features 0 \
--loader_num_workers 1 \
--record_loss_every 100 \
--learning_rate 1e-4 \
--classifier_downsample=none \
--classifier_fc_dims= \
--classifier_proj_dim=0 \
--discriminator_downsample=none \
--discriminator_fc_dims= \
--discriminator_proj_dim=0 \
--nmn_use_film=1 \
--nmn_module_pool=max \
--module_num_layers=2 \
--nmn_use_gammas=tanh \
--classifier_fc_dims=1024 \
--batch_size 128 \
--allow_resume True \
--checkpoint_path /om2/user/vanessad/understanding_reasoning/CLOSURE-master/results/CoGenT/with_bn/vector_${SLURM_ARRAY_TASK_ID} \
--data_dir /om2/user/vanessad/understanding_reasoning/CLOSURE-master/dataset_visual_bias \
$@
