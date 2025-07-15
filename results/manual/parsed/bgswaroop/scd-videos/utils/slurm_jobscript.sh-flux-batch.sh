#!/bin/bash
#FLUX: --job-name=res
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/data/p288722/softwares/cuda/lib64'

module purge
module load OpenBLAS/0.3.15-GCC-10.3.0
module load CUDAcore/11.1.1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/p288722/softwares/cuda/lib64
source /data/p288722/python_venv/scd_videos_first_revision/bin/activate
num_frames=50
base_dir=$(pwd)
all_I_frames_dir="/data/p288722/datasets/vision/all_I_frames"
all_frames_dir="/data/p288722/datasets/vision/all_frames"
net="res"
const_type="None"
category="None"
case ${net} in
"mobile") model_name="MobileNet_${num_frames}_I_frames_run${SLURM_ARRAY_TASK_ID}" ;;
"misl") model_name="MISLNet_${num_frames}_I_frames_run${SLURM_ARRAY_TASK_ID}" ;;
"res") model_name="ResNet_${num_frames}_I_frames_run${SLURM_ARRAY_TASK_ID}" ;;
*) exit 1 ;;
esac
case ${const_type} in
"derrick") model_name="${model_name}_Const" ;;
"None") ;;
*) exit 1 ;;
esac
case ${category} in
"native") model_name="${model_name}_na" ;;
"whatsapp") model_name="${model_name}_wa" ;;
"youtube") model_name="${model_name}_yt" ;;
"None") ;;
*) exit 1 ;;
esac
lscpu
nvidia-smi
dataset_params="--dataset_name=vision --frame_selection=equally_spaced --frame_type=I --fpv=50 --height=480 --width=800 --all_I_frames_dir=${all_I_frames_dir} --all_frames_dir=${all_frames_dir}"
python3 /home/p288722/git_code/scd_videos_first_revision/run_train.py ${dataset_params} --category=${category} --net_type=${net}  --epochs=20 --lr=0.1 --batch_size=32 --use_pretrained=1 --gpu_id=0 --const_type=${const_type} --model_name="${model_name}" --global_results_dir="${base_dir}/${num_frames}_frames/${net}_net"
python3 /home/p288722/git_code/scd_videos_first_revision/run_evaluate.py ${dataset_params} --eval_set="val" --batch_size=64 --gpu_id=0 --suffix="${num_frames}_frames_val" --input_dir="${base_dir}/${num_frames}_frames/${net}_net/models/${model_name}"
python3 /home/p288722/git_code/scd_videos_first_revision/utils/predict_utils/select_best_model.py --val_summary="${base_dir}/${num_frames}_frames/${net}_net/models/${model_name}/predictions_${num_frames}_frames_val/videos/V_prediction_stats.csv"
python3 /home/p288722/git_code/scd_videos_first_revision/run_evaluate.py ${dataset_params} --eval_set="test" --batch_size=64 --gpu_id=0 --suffix="${num_frames}_frames" --input_dir="${base_dir}/${num_frames}_frames_pred/${net}_net/models/${model_name}"
