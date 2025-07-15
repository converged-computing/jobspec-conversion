#!/bin/bash
#FLUX: --job-name=fuzzy-poodle-5488
#FLUX: -t=86400
#FLUX: --priority=16

export NODELIST='nodelist.$'
export HOROVOD_GPU_ALLREDUCE='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_BROADCAST='MPI'
export NCCL_DEBUG='DEBUG'

HOME2=/nobackup/users/$(whoami)
HOME3=/nobackup/users/swhan
PYTHON_VIRTUAL_ENVIRONMENT=neurips
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
python train_wt.py \
--dataset WT64_hdf5 --shuffle --parallel --num_workers 8 --batch_size 256 --load_in_mem \
--base_root $HOME3/ICLR/biggan/BigGAN-PyTorch-3/results_deep_hdf5/ --data_root $HOME3/BigGAN-PyTorch1/data/ILSVRC_WT64.hdf5 \
--norm_path /nobackup/users/swhan/BigGAN-PyTorch1/WT64_norm_values.npz \
--num_G_accumulations 4 --num_D_accumulations 4 \
--num_D_steps 1 --G_lr 1e-4 --D_lr 4e-4 --D_B2 0.999 --G_B2 0.999 \
--G_attn 32 --D_attn 32 \
--G_nl inplace_relu --D_nl inplace_relu \
--SN_eps 1e-6 --BN_eps 1e-5 --adam_eps 1e-6 \
--G_ortho 0.0 \
--G_shared \
--G_init ortho --D_init ortho \
--hier --dim_z 120 --shared_dim 128 \
--G_ch 96 --D_ch 96 \
--ema --use_ema --ema_start 20000 --G_eval_mode \
--test_every 2000 --save_every 2000 --num_best_copies 5 --num_save_copies 2 --seed 0 \
--use_multiepoch_sampler --num_epochs=100 \
--wandb_project biggan_bs1024_hdf5_3 \
--experiment_name BigGAN_WT64_hdf5_seed0_Gch96_Dch96_bs256_nDa4_nGa4_Glr1.0e-04_Dlr4.0e-04_Gnlinplace_relu_Dnlinplace_relu_Ginitortho_Dinitortho_Gattn32_Dattn32_Gshared_hier_ema \
--resume --load_weights copy0 \
echo "Run completed at:- "
date
