#!/bin/bash
#FLUX: --job-name=delicious-blackbean-2459
#FLUX: --priority=16

python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar10 --buffer_size 500  --csv_log --with_brain_vit --num_classes 10 --num_workers 12 --kappa 2 --lmbda 0.1 --delta 0.01 --k 5 --with_slow > ablation_exp/exp2/cifar10_k_5.log 2>&1
python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-imagenet-r --buffer_size 600  --csv_log --with_brain_vit --num_classes 200 --num_workers 12 --kappa 2 --lmbda 0.1 --delta 0.01 --k 2
CUDA_VISIBLE_DEVICES='0' python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar10 --buffer_size 500  --csv_log --with_brain_vit --num_classes 10 --num_workers 12 --kappa 1 --lmbda 0.1 --delta 0.01 --k 4 --with_slow --slow_model PureMM
CUDA_VISIBLE_DEVICES='1' python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar100 --buffer_size 500  --csv_log --with_brain_vit --num_classes 100 --num_workers 12 --kappa 1 --lmbda 0.1 --delta 0.01 --k 4 --with_slow --slow_model PureMM
CUDA_VISIBLE_DEVICES='0' python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-imagenet-r --buffer_size 600  --csv_log --with_brain_vit --num_classes 200 --num_workers 12 --kappa 1 --lmbda 0.1 --delta 0.01 --k 4 --with_slow --slow_model PureMM
CUDA_VISIBLE_DEVICES='0' python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar10 --buffer_size 500  --csv_log --with_brain_vit --num_classes 10 --num_workers 12 --kappa 1 --lmbda 0.1 --delta 0.01 --k 4 --with_slow --slow_model INF-MLLM
CUDA_VISIBLE_DEVICES='1' python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar100 --buffer_size 500  --csv_log --with_brain_vit --num_classes 100 --num_workers 12 --kappa 1 --lmbda 0.1 --delta 0.01 --k 4 --with_slow --slow_model INF-MLLM
CUDA_VISIBLE_DEVICES='0' python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-imagenet-r --buffer_size 600  --csv_log --with_brain_vit --num_classes 200 --num_workers 12 --kappa 1 --lmbda 0.1 --delta 0.01 --k 4 --with_slow --slow_model INF-MLLM
