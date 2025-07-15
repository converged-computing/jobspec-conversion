#!/bin/bash
#FLUX: --job-name="ht"
#FLUX: -c=74
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --priority=16

echo " "
echo " Nodelist:= " $SLURM_JOB_NODELIST
echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
echo " GPUs per node:= " $SLURM_JOB_GPUS
echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo " Running on multiple nodes/GPU devices"
echo ""
echo " Run started at:- "
date
source /nobackup/users/duartek/anaconda3/bin/activate
conda activate wmlce-1.6.2
nvidia-smi
pwd
python -u train_tri_kmeans.py --num_thread_reader=74 --epochs=10 --batch_size=128 \
--n_pair=32 --embd_dim=6144 --howto_audio_frames=1000 --min_time=10.0 --random_audio_windows=0  \
--lr=0.0001 --tri_modal=1 --apex_level=1 --kmeans=1 --use_queue=1 --queue_size=20 --fastC=1 --mean=1 --recon=1 --recon_size=1024 \
--features_path=/nobackup/users/kaudhkha/sightsound/data/howto/parsed_videos \
--features_path_audio=/nobackup/projects/public/howto100m/parsed_videos \
--pretrain_path=model_mcn/MCN_KMeans/e16.pth --train_csv=data/HowTo100M_336_videopaths.txt \
--checkpoint_dir=model_mcn/MCN_KMeans >> logs/MCN_KMeans
wait 
echo "Run completed at:- "
date
