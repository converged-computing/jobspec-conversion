#!/bin/bash
#FLUX: --job-name=mlperf-hpc:openfold-reference
#FLUX: -N=16
#FLUX: --exclusive
#FLUX: -t=8100
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export DATESTAMP='$(date +"%y%m%d%H%M%S%N")'
export EXP_ID='1'

echo "START" $(date +"%Y-%m-%d %H:%M:%S")
echo "SLURM_JOB_ID=$SLURM_JOB_ID"
echo "SLURM_JOB_NUM_NODES=$SLURM_JOB_NUM_NODES"
echo "SLURM_NODELIST=$SLURM_NODELIST"
srun \
--mpi=none \
--container-image=openfold_pyt \
--container-name=$SLURM_JOB_ID \
bash -c 'echo "srun SLURM_JOB_ID=$SLURM_JOB_ID SLURMD_NODENAME=$SLURMD_NODENAME"'
echo "READY" $(date +"%Y-%m-%d %H:%M:%S")
export OMP_NUM_THREADS=1
export DATESTAMP=$(date +"%y%m%d%H%M%S%N")
export EXP_ID=1
srun \
--mpi=none \
--container-name=$SLURM_JOB_ID \
--container-mounts=/path/to/data:/data:ro,/path/to/training_rundir:/training_rundir \
bash -c \
'echo "srun SLURMD_NODENAME=$SLURMD_NODENAME MASTER_ADDR=$MASTER_ADDR MASTER_PORT=$MASTER_PORT"; \
torchrun \
--nnodes=$SLURM_JOB_NUM_NODES \
--nproc_per_node=8 \
--rdzv_id=$SLURM_JOB_ID \
--rdzv_backend=c10d \
--rdzv_endpoint=$MASTER_ADDR:$MASTER_PORT \
train.py \
--training_dirpath /training_rundir \
--pdb_mmcif_chains_filepath /data/pdb_mmcif/processed/chains.csv \
--pdb_mmcif_dicts_dirpath /data/pdb_mmcif/processed/dicts \
--pdb_obsolete_filepath /data/pdb_mmcif/processed/obsolete.dat \
--pdb_alignments_dirpath /data/open_protein_set/processed/pdb_alignments \
--initialize_parameters_from /data/mlperf_hpc_openfold_resumable_checkpoint.pt \
--seed 1234567890 \
--num_train_iters 2000 \
--val_every_iters 40 \
--local_batch_size 1 \
--base_lr 1e-3 \
--warmup_lr_init 1e-5 \
--warmup_lr_iters 0 \
--num_train_dataloader_workers 14 \
--num_val_dataloader_workers 2 \
--distributed'
