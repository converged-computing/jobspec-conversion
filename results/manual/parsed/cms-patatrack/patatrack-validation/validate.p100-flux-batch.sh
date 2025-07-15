#!/bin/bash
#FLUX: --job-name=misunderstood-nalgas-7336
#FLUX: --queue=gpu --nodes=1 --tasks-per-node=1 --cpus-per-task=20 --gres=gpu:2 --constraint=p100 -o validation.%j.out -e validation.%j.err
#FLUX: --priority=16

module purge
module load gcc/8.3.0
module load cuda/10.1.105_418.39
echo Host: `hostname`
echo Available CPU cores:
taskset -c -p $$ | cut -d' ' -f3- | sed -e's/c/C/' -e's/^/  /'
echo Avaliable GPUs:
nvidia-smi -L | sed -e's/^/  /'
./validate "$@"
