#!/bin/bash
#SBATCH --job-name=vit2
#SBATCH --output=vit2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:nvidia_rtx_a6000:1
#SBATCH --time=12:00:00
#SBATCH --partition=compute
#SBATCH --nodelist=gpu07

python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar10 --buffer_size 200  --csv_log --num_classes 10 --num_workers 12 --vit_finetune
python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-cifar100 --buffer_size 200  --num_classes 100 --num_workers 12 --vit_finetune
python /home/bqqi/ICL/utils/main.py --model onlinevt --load_best_args --dataset seq-imagenet-r --buffer_size 200  --num_classes 200 --num_workers 12 --vit_finetune
