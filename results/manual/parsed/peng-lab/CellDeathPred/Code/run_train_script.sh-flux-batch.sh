#!/bin/bash
#FLUX: --job-name=loopy-itch-2090
#FLUX: --queue=gpu_p
#FLUX: --urgency=15

echo $HOME
source $HOME/.bashrc
echo 'Starting python script'
source $HOME/miniconda2/bin/activate #conda 
cd /home/haicu/alaa.bessadok/for_Alaa/ # where your project is located
conda activate hcs_env_3
exper_name="train_exp67_2"
dataset="dataset_exp67"
echo $(date '+%Y-%m-%d') >> /home/haicu/alaa.bessadok/for_Alaa/logs_slurm/list_jobs_date.txt
echo $SLURM_JOB_ID >> /home/haicu/alaa.bessadok/for_Alaa/logs_slurm/list_jobs_date.txt
echo $exper_name >> /home/haicu/alaa.bessadok/for_Alaa/logs_slurm/list_jobs_date.txt
echo $dataset >> /home/haicu/alaa.bessadok/for_Alaa/logs_slurm/list_jobs_date.txt
echo 'exp67; bn 0.1; metric 0.5 + ce 0.5; efficientnet_b0, range2; train plates 1,2,5,6,7,8,10; temp 0.1;FREEZE BN; all fields' >> /home/haicu/alaa.bessadok/for_Alaa/logs_slurm/list_jobs_date.txt
echo "" >> /home/haicu/alaa.bessadok/for_Alaa/logs_slurm/list_jobs_date.txt # empty line
python /home/haicu/alaa.bessadok/for_Alaa/main.py  --seed 0 --log_path "/home/haicu/alaa.bessadok/for_Alaa/logs_${exper_name}" --model_save_path "/home/haicu/alaa.bessadok/for_Alaa/saved_models_${exper_name}" --tensorboard_path "/home/haicu/alaa.bessadok/for_Alaa/tensorboard_${exper_name}" --mode 'train' --classes 3  --ds "${dataset}" --bn_mom 0.1 --epochs 300 --embedding_size 1280 --backbone 'efficientnet_b0' --miner_margin 0.01 --metric_loss_weight 0.5 --batch_size 42 --samples_per_class 2 --lr_const 1.25e-5 --classifier_loss_weight 0.5 --triplet_margin 0.01 --disable_emb True --crop True --avg_embs True --exper_name ${exper_name} --lr_scheduler True --my_miner False --ds_h '24' --select_plates 1,2,5,6,7,8,10 --choose_range 'range2' --load_model 'train_exp7_1' --checkpoint 260 --stain 3
echo $SLURM_JOB_ID > /home/haicu/alaa.bessadok/for_Alaa/logs_with_${exper_name}/job_name.txt
