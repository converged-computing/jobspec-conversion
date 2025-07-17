#!/bin/bash
#FLUX: --job-name=bumfuzzled-butter-3069
#FLUX: -N=2
#FLUX: --queue=gpumedium
#FLUX: -t=900
#FLUX: --urgency=16

export SING_FLAGS='$SING_FLAGS -B /appl/spack/v014/install-tree/gcc-4.8.5/pdsh-2.31-cdzt5w/bin:/usr/local/sbin'

module purge
module load gcc/10.3.0 cuda/11.2.2 pytorch/1.9 pdsh/2.31
export SING_FLAGS="$SING_FLAGS -B /appl/spack/v014/install-tree/gcc-4.8.5/pdsh-2.31-cdzt5w/bin:/usr/local/sbin"
which pdsh
python -c 'import shutil; print(shutil.which("pdsh"))'
OUTPUT_DIR=output_dir
rm -rf "$OUTPUT_DIR"
rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOBID.out logs/latest.out
ln -s $SLURM_JOBID.err logs/latest.err
MASTER_NODE=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
HOSTFILE=hostfiles/$SLURM_JOBID.txt
rm -f hostfiles/latest.txt
ln -s $SLURM_JOBID.txt hostfiles/latest.txt
scontrol show hostnames "$SLURM_JOB_NODELIST" \
    | perl -pe 's/$/ slots=4/' \
    > "$HOSTFILE"
./deepspeed_singularity.sh \
    --master_addr "$MASTER_NODE" \
    --hostfile "$HOSTFILE" \
    run_clm.py \
    --tokenizer tokenizer \
    --model_type gpt2 \
    --train_file texts.txt \
    --do_train \
    --num_train_epochs 1 \
    --per_device_train_batch_size 6 \
    --output_dir "$OUTPUT_DIR" \
    --deepspeed ds_config.json
