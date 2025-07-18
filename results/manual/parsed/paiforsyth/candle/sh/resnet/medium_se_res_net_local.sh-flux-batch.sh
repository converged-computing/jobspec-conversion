#!/bin/bash
#FLUX: --job-name=tart-sundae-8053
#FLUX: -c=6
#FLUX: -t=720
#FLUX: --urgency=16

python -m examples.lab --save_prefix=anneal-medium --dataset_for_classification=cifar_challenge --model_type=squeezenet --squeezenet_out_dim=100 --squeezenet_in_channels=3  --squeezenet_mode=next_fire --squeezenet_next_fire_groups=1 --squeezenet_pool_interval_mode=multiply  --squeezenet_base=256 --squeezenet_freq=3 --squeezenet_sr=0.25 --fire_skip_mode=simple --squeezenet_num_fires=9 --squeezenet_pool_interval=3 --squeezenet_conv1_stride=1 --squeezenet_conv1_size=3 --squeezenet_num_conv1_filters=63 --squeezenet_pooling_count_offset=0 --squeezenet_max_pool_size=2 --squeezenet_pool_interval_mode=multiply  --squeezenet_use_excitation --batch_size=64 --num_epochs=300 --optimizer=sgd --sgd_momentum=0.9 --sgd_weight_decay=0.0001 --init_lr=0.2 --lr_scheduler=epoch_anneal --epoch_anneal_numcycles=5   --epoch_anneal_save_last --squeezenet_num_layer_chunks=1 --cifar_random_erase --proxy_context_type=group_prune_context  --save_every_epoch --use_no_grad --cuda   
