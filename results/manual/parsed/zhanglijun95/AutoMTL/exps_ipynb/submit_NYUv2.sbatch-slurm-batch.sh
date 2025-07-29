#!/bin/bash
#FLUX: --job-name=NYUSample3
#FLUX: --queue=m40-long
#FLUX: -t=604800
#FLUX: --urgency=16

echo `pwd`
set -x -e
__conda_setup="$('/home/lijunzhang/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/home/lijunzhang/anaconda3/etc/profile.d/conda.sh" ]; then
		. "/home/lijunzhang/anaconda3/etc/profile.d/conda.sh"
	else
		export PATH="/home/lijunzhang/anaconda3/bin:$PATH"
	fi  
fi
unset __conda_setup
conda init bash
conda activate multitask
sleep 1
python experiments_sample.py --seed=10 --sample_dir='sample_design3_001/' --data='NYUv2' --ckpt_dir='checkpoint/NYUv2/' --reload_ckpt='alter_train_with_reg_001_20000iter.model' --print_iters=150 --val_iters=300 --task_iters 50 50 50
sleep 1
exit
