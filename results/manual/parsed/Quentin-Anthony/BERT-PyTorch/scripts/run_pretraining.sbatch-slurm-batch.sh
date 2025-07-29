#!/bin/bash
#FLUX: --job-name=bert-pretrain
#FLUX: -N=16
#FLUX: -n=32
#FLUX: --queue=v100
#FLUX: -t=172800
#FLUX: --urgency=16

PHASE=1
if [[ "$PHASE" -eq 1 ]]; then
    CONFIG=config/bert_pretraining_phase1_config.json
    DATA=/lus/theta-fs0/projects/SuperBERT/jgpaul/datasets/encoded/wikibooks/static_masked_30K/sequences_lowercase_max_seq_len_128_next_seq_task_true/
else
    CONFIG=config/bert_pretraining_phase1_config.json
    DATA=/lus/theta-fs0/projects/SuperBERT/jgpaul/datasets/encoded/wikibooks/static_masked_30K/sequences_lowercase_max_seq_len_128_next_seq_task_true/
fi
OUTPUT_DIR=results/bert_large_uncased_wikibooks_pretraining
if [[ -z "${SLURM_NODELIST}" ]]; then
    RANKS=$HOSTNAME
    NNODES=1
else
    NODEFILE=/tmp/nodefile
    scontrol show hostnames $SLURM_NODELIST > $NODEFILE
    MASTER_RANK=$(head -n 1 $NODEFILE)
    RANKS=$(tr '\n' ' ' < $NODEFILE)
    NNODES=$(< $NODEFILE wc -l)
fi
PRELOAD+="module load conda ; "
PRELOAD+="conda activate pytorch ; "
PRELOAD+="export OMP_NUM_THREADS=8 ; "
LAUNCHER="python -m torch.distributed.run "
LAUNCHER+="--nnodes=$NNODES --nproc_per_node=auto --max_restarts 0 "
if [[ "$NNODES" -eq 1 ]]; then
    LAUNCHER+="--standalone "
else
    LAUNCHER+="--rdzv_backend=c10d --rdzv_endpoint=$MASTER_RANK "
fi
CMD="run_pretraining.py --input_dir $DATA --output_dir $OUTPUT_DIR --config_file $CONFIG "
FULL_CMD=" $PRELOAD $LAUNCHER $CMD $@ "
echo "Training Command: $FULL_CMD"
RANK=0
for NODE in $RANKS; do
    if [[ "$NODE" == "$HOSTNAME" ]]; then
        echo "Launching rank $RANK on local node $NODE"
        eval $FULL_CMD &
    else
        echo "Launching rank $RANK on remote node $NODE"
        ssh $NODE "cd $PWD; $FULL_CMD" &
    fi
    RANK=$((RANK+1))
done
wait
