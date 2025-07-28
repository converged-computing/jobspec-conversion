#!/bin/bash
#FLUX: --job-name=pytorch_test
#FLUX: --queue=small
#FLUX: -t=540
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$lib_path_of_current_enviroment'

which python
export LD_LIBRARY_PATH=""
l=$(which python)
lib_path_of_current_enviroment="${l%%python}"
echo "Ld library ${lib_path_of_current_enviroment}"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$lib_path_of_current_enviroment
python -c "import os; print(os.environ)"
python train_CIFAR10.py --resume --save_folder "/jmain02/home/J2AD014/mtc03/lla98-mtc03/checkpoints" --batch_size 128  --model $1 --dataset $2 --num_workers $3 --RF_level $4 --type $5 --epochs $6  --name $7 --width $8 --record $9 --resume_solution "${10}"
