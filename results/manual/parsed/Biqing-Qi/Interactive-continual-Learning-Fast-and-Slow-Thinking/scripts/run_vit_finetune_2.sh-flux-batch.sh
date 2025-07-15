#!/bin/bash
#FLUX: --job-name=reclusive-latke-0726
#FLUX: --priority=16

python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar10 --buffer_size 200  --csv_log --num_classes 10 --num_workers 12 --vit_finetune
python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar100 --buffer_size 200  --num_classes 100 --num_workers 12 --vit_finetune
python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-imagenet-r --buffer_size 200  --num_classes 200 --num_workers 12 --vit_finetune
