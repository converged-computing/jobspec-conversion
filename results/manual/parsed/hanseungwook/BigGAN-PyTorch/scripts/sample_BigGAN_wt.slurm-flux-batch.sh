#!/bin/bash
#FLUX: --job-name=biggan_sample
#FLUX: --queue=sched_system_all
#FLUX: -t=86400
#FLUX: --urgency=16

export NODELIST='nodelist.$'
export HOROVOD_GPU_ALLREDUCE='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_BROADCAST='MPI'
export NCCL_DEBUG='DEBUG'

HOME2=/nobackup/users/$(whoami)
PYTHON_VIRTUAL_ENVIRONMENT=wmlce-ea
CONDA_ROOT=$HOME2/anaconda3
source ${CONDA_ROOT}/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
ulimit -s unlimited
export NODELIST=nodelist.$
srun -l bash -c 'hostname' |  sort -k 2 -u | awk -vORS=, '{print $2":4"}' | sed 's/,$//' > $NODELIST
echo " "
echo " Nodelist:= " $SLURM_JOB_NODELIST
echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
echo " NGPUs per node:= " $SLURM_GPUS_PER_NODE 
echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
export HOROVOD_GPU_ALLREDUCE=MPI
export HOROVOD_GPU_ALLGATHER=MPI
export HOROVOD_GPU_BROADCAST=MPI
export NCCL_DEBUG=DEBUG
echo " Running on multiple nodes and GPU devices"
echo ""
echo " Run started at:- "
date
python sample_wt.py \
--dataset WT64 --shuffle  --num_workers 8 --batch_size 256 \
--base_root /nobackup/users/swhan/ICLR/biggan/BigGAN-PyTorch-3/results_deep_hdf5 --data_root /data/ImageNet/ILSVRC2012/train/ \
--norm_path $HOME2/BigGAN-PyTorch/WT64_norm_values.npz \
--num_G_accumulations 2 --num_D_accumulations 2 \
--num_D_steps 1 --G_lr 1e-4 --D_lr 4e-4 --D_B2 0.999 --G_B2 0.999 \
--G_attn 32 --D_attn 32 \
--G_ch 128 --D_ch 128 \
--G_depth 2 --D_depth 2 \
--G_nl inplace_relu --D_nl inplace_relu \
--SN_eps 1e-6 --BN_eps 1e-5 --adam_eps 1e-6 \
--G_ortho 0.0 \
--G_shared \
--G_init ortho --D_init ortho \
--hier --dim_z 128 --shared_dim 128 \
--ema --use_ema --ema_start 20000 --G_eval_mode \
--test_every 2000 --save_every 2000 --num_best_copies 5 --num_save_copies 2 --seed 0 \
--use_multiepoch_sampler --num_epochs=100 \
--resume --load_weights copy1 \
--experiment_name BigGAN_WT64_hdf5_seed0_Gch96_Dch96_bs256_nDa4_nGa4_Glr1.0e-04_Dlr4.0e-04_Gnlinplace_relu_Dnlinplace_relu_Ginitortho_Dinitortho_Gattn32_Dattn32_Gshared_hier_ema/ \
--G_batch_size 512 --sample_trunc_curves 0.05_0.05_1.0 --z_var 1.0 
echo "Run completed at:- "
date
