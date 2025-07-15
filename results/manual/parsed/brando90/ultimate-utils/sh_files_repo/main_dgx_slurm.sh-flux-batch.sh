#!/bin/bash
#FLUX: --job-name="job_bmg"
#FLUX: --queue=x86
#FLUX: -t=172800
#FLUX: --priority=16

srun --partition=x86 --time=48:00:00 --pty /bin/bash
srun --partition=x86 --time=48:00:00 --nodes=1 --ntasks-per-node=32 --sockets-per-node=1 --cores-per-socket=16 --threads-per-core=2 --mem-per-cpu=4000 --wait=0 --export=ALL --pty /bin/bash
srun --partition=x86 --time=48:00:00 --nodes=1 --ntasks-per-node=32 --sockets-per-node=1 --cores-per-socket=16 --threads-per-core=2 --mem-per-cpu=4000 --wait=0 --export=ALL --gres=gpu:a100:1 --pty /bin/bash
cd ~
echo STARTING `date`
srun hostname
nvidia-smi
python -c "import torch;print(torch.version.cuda)"
nvcc -V
echo CUDA_VISIBLE_DEVICES
echo $CUDA_VISIBLE_DEVICES
echo torch.cuda.device_count is:
python -c "import torch; print(torch.cuda.device_count())"
echo ---- Running your python main ----
python -m torch.distributed.run --nproc_per_node=1 ~/diversity-for-predictive-success-of-meta-learning/div_src/diversity_src/experiment_mains/main_dist_maml_l2l.py --manual_loads_name l2l_resnet12rfs_hdb1_100k
python -u ~/diversity-for-predictive-success-of-meta-learning/div_src/diversity_src/experiment_mains/main2_distance_sl_vs_maml.py
/home/miranda9/miniconda3/envs/meta_learning_a100/bin/python -m pi install --upgrade pip
pip install wandb --upgrade
conda update conda
conda update --all
pip install --upgrade pip
pip3 install --upgrade pip
echo -- Done submitting job in dgx A100-SXM4-40G
