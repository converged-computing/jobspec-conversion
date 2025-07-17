#!/bin/bash
#FLUX: --job-name=inet_supervised_resnet152_lineareval
#FLUX: -c=8
#FLUX: -t=18000
#FLUX: --urgency=16

i=0;
for wd in 1e-6 1e-5 1e-4;
do 
	for run in 0 1 2 3 4 5 6 7 8 9;
	do 
			for model in resnet50;
			do 
				for data in  inaturalist18; 
				do 	
					wds[$i]=$wd;
					models[$i]=$model;
					runs[$i]=$run; 
					datas[$i]=$data;
					i=$(($i+1));
				done 
			done
	done 
done 
final_run=${runs[$SLURM_ARRAY_TASK_ID]}
final_model=${models[$SLURM_ARRAY_TASK_ID]}
final_data=${datas[$SLURM_ARRAY_TASK_ID]}
final_cf=${cfs[$SLURM_ARRAY_TASK_ID]}
final_wd=${wds[$SLURM_ARRAY_TASK_ID]}
resdir=results/supervised/imagenet/transfer/lineareval_seer/${final_data}_${final_wd}/${final_model}/run${final_run}
mkdir ${resdir} -p
EXPERIMENT_PATH=$resdir
srun --output=${EXPERIMENT_PATH}/%j.out --error=${EXPERIMENT_PATH}/%j.err python supervised.py  --dump_path ${resdir}  \
--tag supervisedimagenet_resnet50_run${final_run} \
--data_name ${final_data}  --classifier linear --batch_size 32  --data_path data/inaturalist18/   --wd ${final_wd} \
--exp_mode lineareval --nesterov True --wd_skip_bn True \
--headinit normal --use_bn True  --eval_freq 1 --sync_bn True  || scontrol requeue $SLURM_JOB_ID
