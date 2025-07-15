#!/bin/bash
#FLUX: --job-name=bumfuzzled-cat-6270
#FLUX: --priority=16

export MV2_USE_CUDA='1'
export MV2_ENABLE_AFFINITY='1'
export MV2_THREADS_PER_PROCESS='2'
export MV2_SHOW_CPU_BINDING='1'
export MV2_CPU_BINDING_POLICY='hybrid'
export MV2_HYBRID_BINDING_POLICY='spread'
export MV2_USE_RDMA_CM='0'
export MV2_SUPPORT_DL='1'

mkdir -p sbatch_logs
module load conda
conda activate pytorch
module unload spectrum_mpi
module use /home/01255/siliu/mvapich2-gdr/modulefiles/
module load gcc/7.3.0 
module load mvapich2-gdr/2.3.4
export MV2_USE_CUDA=1
export MV2_ENABLE_AFFINITY=1
export MV2_THREADS_PER_PROCESS=2
export MV2_SHOW_CPU_BINDING=1
export MV2_CPU_BINDING_POLICY=hybrid
export MV2_HYBRID_BINDING_POLICY=spread
export MV2_USE_RDMA_CM=0
export MV2_SUPPORT_DL=1
HOSTFILE=hostfile
cat $HOSTFILE
MASTER_RANK=$(head -n 1 $HOSTFILE)
NODES=$(< $HOSTFILE wc -l)
PROC_PER_NODE=4
mpirun -np $NODES -hostfile $HOSTFILE  bash scripts/launch_pretraining.sh  \
    --ngpus $PROC_PER_NODE --nnodes $NODES --master $MASTER_RANK \
    --config config/bert_pretraining_phase1_config.json \
	--input data/hdf5/lower_case_1_seq_len_128_max_pred_20_masked_lm_prob_0.15_random_seed_12345_dupe_factor_5/wikicorpus_en/ \
    --output results/bert_pretraining
mpirun -np $NODES -hostfile $HOSTFILE  bash scripts/launch_pretraining.sh  \
    --ngpus $PROC_PER_NODE --nnodes $NODES --master $MASTER_RANK \
    --config config/bert_pretraining_phase2_config.json \
	--input data/hdf5/lower_case_1_seq_len_512_max_pred_80_masked_lm_prob_0.15_random_seed_12345_dupe_factor_5/wikicorpus_en/ \
    --output results/bert_pretraining
