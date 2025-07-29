#!/bin/bash
#SBATCH --job-name=NYUSample3
#SBATCH --output=exp/exp_output/run_logs_%j.out
#SBATCH --error=exp/exp_output/run_logs_%j.err
#SBATCH --mail-user=lijunzhang@cs.umass.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4096
#SBATCH --time=7-00:00:00
#SBATCH --partition=m40-long
#SBATCH --exclude=node007

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
