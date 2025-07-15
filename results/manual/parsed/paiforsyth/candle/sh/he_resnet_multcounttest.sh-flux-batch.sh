#!/bin/bash
#FLUX: --job-name=adorable-hope-0062
#FLUX: -c=6
#FLUX: -t=720
#FLUX: --urgency=16

python -m examples.lab --save_prefix=zag --dataset_for_classification=cifar10 --model_type=squeezenet --squeezenet_bypass_first_last --squeezenet_out_dim=1000 --squeezenet_in_channels=3  --squeezenet_mode=zag_fire  --squeezenet_pool_interval_mode=multiply  --squeezenet_base=64 --squeezenet_freq=2   --squeezenet_num_fires=8 --squeezenet_pool_interval=2 --squeezenet_conv1_stride=1 --squeezenet_conv1_size=3 --squeezenet_num_conv1_filters=16 --squeezenet_pooling_count_offset=1 --squeezenet_max_pool_size=2   --batch_size=128 --num_epochs=200 --optimizer=sgd --sgd_momentum=0.9  --init_lr=0.2 --lr_scheduler=epoch_anneal --sgd_weight_decay=0.0005  --epoch_anneal_numcycles=1   --epoch_anneal_save_last --squeezenet_num_layer_chunks=1 --cifar_random_erase --proxy_context_type=no_context     --save_every_epoch --use_no_grad --count_multiplies  --count_mult_override_img_dims --count_mult_override_imgh=56 --count_mult_override_imgw=56   # --param_report  #--mod_report  #--count_multiplies # --count_multiplies_every_cycle --cuda   
