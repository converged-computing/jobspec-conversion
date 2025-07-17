#!/bin/bash
#FLUX: --job-name=mlperf-hpc:openfold-reference
#FLUX: -N=18
#FLUX: -n=18
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

export CONT='/scratch/nnisbet/mlperf_hpc-openfold_latest.sif'
export OMP_NUM_THREADS='1'
export UCX_POSIX_USE_PROC_LINK='n'
export NCCL_ASYNC_ERROR_HANDLING='1'
export DATESTAMP='$(date +"%y%m%d%H%M%S%N")'
export EXP_ID='1'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'

module purge
module add openmpi/4.1.5
echo "START" $(date +"%Y-%m-%d %H:%M:%S")
echo "SLURM_JOB_ID=$SLURM_JOB_ID"
echo "SLURM_JOB_NUM_NODES=$SLURM_JOB_NUM_NODES"
echo "SLURM_NODELIST=$SLURM_NODELIST"
export CONT=/scratch/nnisbet/mlperf_hpc-openfold_latest.sif
echo "READY" $(date +"%Y-%m-%d %H:%M:%S")
export OMP_NUM_THREADS=1
export UCX_POSIX_USE_PROC_LINK=n
export NCCL_ASYNC_ERROR_HANDLING=1
export DATESTAMP=$(date +"%y%m%d%H%M%S%N")
export EXP_ID=1
echo "NODELIST="${SLURM_NODELIST}
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
for _experiment_index in $(seq 1 10); do
(
	# Clear caches
	srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
	export SEED=${_seed_override:-$(date +%s)}
	# Run the command:
	srun \
	--mpi=pmi2 \
	apptainer exec --nv -B /etc/hosts:/etc/hosts,/scratch/nnisbet/openfold:/data:rw,$PWD:/training_rundir \
	$CONT \
	bash -c \
	'echo "srun SLURMD_NODENAME=$SLURMD_NODENAME MASTER_ADDR=$MASTER_ADDR"; \
	torchrun \
	--nnodes=$SLURM_JOB_NUM_NODES \
	--nproc_per_node=2 \
	--rdzv_id=$SLURM_JOB_ID \
	--rdzv_backend=c10d \
	--rdzv_endpoint=$MASTER_ADDR \
	/training_rundir/train.py \
	--training_dirpath /training_rundir \
	--pdb_mmcif_chains_filepath /data/pdb_mmcif/processed/chains.csv \
	--pdb_mmcif_dicts_dirpath /data/pdb_mmcif/processed/dicts \
	--pdb_obsolete_filepath /data/pdb_mmcif/processed/obsolete.dat \
	--pdb_alignments_dirpath /data/open_protein_set/processed/pdb_alignments \
	--initialize_parameters_from /data/mlperf_hpc_openfold_resumable_checkpoint.pt \
	--seed $SEED \
	--num_train_iters 2000 \
	--val_every_iters 40 \
	--local_batch_size 4 \
	--base_lr 1e-3 \
	--warmup_lr_init 1e-5 \
	--warmup_lr_iters 0 \
	--num_train_dataloader_workers 16 \
	--num_val_dataloader_workers 2 \
	--distributed'
) |& tee "slurm_${DATESTAMP}_${_experiment_index}.out"
done
