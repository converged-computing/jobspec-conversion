#!/bin/bash
#FLUX: --job-name=SimCLR
#FLUX: -c=5
#FLUX: -t=14340
#FLUX: --urgency=16

module purge
module load GCC/6.4.0-2.28 OpenMPI  ### load necessary modules.
conda activate diffuser
MY_ROOT_PATH="/mnt/home/renjie3/Documents/unlearnable/diffusion/diffusers/examples/text_to_image/"
cd ${MY_ROOT_PATH}
JOB_INFO="train stepsize"
MYCOMMEND="python train_text_to_image.py --pretrained_model_name_or_path=CompVis/stable-diffusion-v1-4 --train_data_dir=./haoyu/dataset --use_ema --resolution=512 --center_crop --random_flip --train_batch_size=6 --gradient_accumulation_steps=4 --gradient_checkpointing --max_train_steps=2000 --learning_rate=5e-06 --max_grad_norm=1 --lr_scheduler=constant --lr_warmup_steps=0 --output_dir=results/sd-haoyu-model --checkpointing_steps 100 --job_id ${SLURM_JOB_ID}_1"
MYCOMMEND2="No_commend2 --job_id ${SLURM_JOB_ID}_2"
MYCOMMEND3="No_commend3 --job_id ${SLURM_JOB_ID}_3"
date >>${MY_ROOT_PATH}submit_history.log
echo $SLURM_JOB_ID >>${MY_ROOT_PATH}submit_history.log
echo $JOB_INFO >>${MY_ROOT_PATH}submit_history.log
echo $MYCOMMEND >>${MY_ROOT_PATH}submit_history.log
if [[ "$MYCOMMEND2" != *"No_commend2"* ]]
then
    echo $MYCOMMEND2 >>${MY_ROOT_PATH}submit_history.log
fi
if [[ "$MYCOMMEND3" != *"No_commend3"* ]]
then
    echo $MYCOMMEND3 >>${MY_ROOT_PATH}submit_history.log
fi
echo "---------------------------------------------------------------" >>${MY_ROOT_PATH}submit_history.log
echo $JOB_INFO
echo $MYCOMMEND
$MYCOMMEND 1>${MY_ROOT_PATH}logfile/${SLURM_JOB_ID}_1.log 2>${MY_ROOT_PATH}logfile/${SLURM_JOB_ID}.err &
if [[ "$MYCOMMEND2" != *"No_commend2"* ]]
then
    echo $MYCOMMEND2
    $MYCOMMEND2 1>${MY_ROOT_PATH}logfile/${SLURM_JOB_ID}_2.log 2>${MY_ROOT_PATH}logfile/${SLURM_JOB_ID}_2.err &
fi
if [[ "$MYCOMMEND3" != *"No_commend3"* ]]
then
    echo $MYCOMMEND3
    $MYCOMMEND3 1>${MY_ROOT_PATH}logfile/${SLURM_JOB_ID}_3.log 2>${MY_ROOT_PATH}logfile/${SLURM_JOB_ID}_3.err &
fi
wait
echo -e "JobID:$SLURM_JOB_ID \n JOB_INFO: ${JOB_INFO} \n Python_command: \n ${MYCOMMEND} \n ${MYCOMMEND2} \n ${MYCOMMEND3} \n " | mail -s "[Done] ${SLURM_JOB_ID}" thurenjie@outlook.com
date >>${MY_ROOT_PATH}finish_history.log
echo $SLURM_JOB_ID >>${MY_ROOT_PATH}finish_history.log
echo $JOB_INFO >>${MY_ROOT_PATH}finish_history.log
echo $MYCOMMEND >>${MY_ROOT_PATH}finish_history.log
if [[ "$MYCOMMEND2" != *"No_commend2"* ]]
then
    echo $MYCOMMEND2 >>${MY_ROOT_PATH}finish_history.log
fi
if [[ "$MYCOMMEND3" != *"No_commend3"* ]]
then
    echo $MYCOMMEND3 >>${MY_ROOT_PATH}finish_history.log
fi
echo -e "---------------------------------------------------------------" >>${MY_ROOT_PATH}finish_history.log
scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
