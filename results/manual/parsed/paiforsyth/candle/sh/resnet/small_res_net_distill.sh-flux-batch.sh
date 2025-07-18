#!/bin/bash
#FLUX: --job-name=hairy-bits-1495
#FLUX: -c=6
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load python/3.6.3
source ~/env1/bin/activate
python -m examples.lab --save_prefix=small --dataset_for_classification=cifar_challenge --model_type=squeezenet --squeezenet_out_dim=100 --squeezenet_in_channels=3  --squeezenet_mode=next_fire --squeezenet_next_fire_groups=1 --squeezenet_pool_interval_mode=multiply  --squeezenet_base=64 --squeezenet_freq=3 --squeezenet_sr=0.25 --fire_skip_mode=simple --squeezenet_num_fires=9 --squeezenet_pool_interval=3 --squeezenet_conv1_stride=1 --squeezenet_conv1_size=3 --squeezenet_num_conv1_filters=64 --squeezenet_pooling_count_offset=0 --squeezenet_max_pool_size=2 --squeezenet_pool_interval_mode=multiply   --batch_size=64 --num_epochs=120 --optimizer=sgd --sgd_momentum=0.9  --init_lr=0.2 --lr_scheduler=epoch_anneal --epoch_anneal_numcycles=1   --epoch_anneal_save_last --squeezenet_num_layer_chunks=1 --cifar_random_erase --proxy_context_type=group_prune_context     --save_every_epoch --use_no_grad --report_unpruned  --count_multiplies_every_cycle --born_again_enable --born_again_model_file=lab_saved_models/28_February_2018_Wednesday_03_06_33anneal-wider_checkpoint_1 --born_again_args_file=lab_argfiles/anneal-next-yet-wider-argsfile.sh   --cuda   
