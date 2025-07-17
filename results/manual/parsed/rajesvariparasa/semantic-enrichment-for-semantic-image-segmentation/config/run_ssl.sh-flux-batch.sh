#!/bin/bash
#FLUX: --job-name=bricky-muffin-8983
#FLUX: --queue=shortrun
#FLUX: -t=172800
#FLUX: --urgency=16

if [[ ! -z ${SLURM_JOBID+z} ]]; then
    echo "Setting up SLURM environment"
    # Load the Conda environment
    source /share/common/anaconda/etc/profile.d/conda.sh
    conda activate torch_env
else
    echo "Not a SLURM job"
fi
set -o errexit -o pipefail -o nounset
cd scripts_ssl
INPUT_TYPE="s2"
INPUT_DIR="/share/projects/siamdl/data/small/"
BATCH_SIZE=16
PROCESS_LEVEL="l1c"
PATIENCE=80
NUM_CLASSES=11
LR=0.0005
GAMMA=0.9
WEIGHT_DECAY=1e-7
EPOCHS=60
SSL_TYPE="dual"
OMEGA=0.5
GAMMA_SSL=0.9
LOSS_SSL_1="DiceLoss"
LOSS_SSL_2="L1Loss"
OUT_PATH="/share/projects/siamdl/outputs/${SLURM_JOBID}_$(date +%Y%m%d)_$SSL_TYPE/quickview/"
REMARKS="SSL Run."
mkdir -p $OUT_PATH
echo "Arguments passed to the script:" > $OUT_PATH/arguments.txt
echo "Output Path: $OUT_PATH" >> $OUT_PATH/arguments.txt
echo "Input Type: $INPUT_TYPE" >> $OUT_PATH/arguments.txt
echo "Batch Size: $BATCH_SIZE" >> $OUT_PATH/arguments.txt
echo "Process Level: $PROCESS_LEVEL" >> $OUT_PATH/arguments.txt
echo "Omega: $OMEGA" >> $OUT_PATH/arguments.txt
echo "Patience: $PATIENCE" >> $OUT_PATH/arguments.txt
echo "Number of Classes: $NUM_CLASSES" >> $OUT_PATH/arguments.txt
echo "Learning Rate: $LR" >> $OUT_PATH/arguments.txt
echo "Weight Decay: $WEIGHT_DECAY" >> $OUT_PATH/arguments.txt
echo "Epochs: $EPOCHS" >> $OUT_PATH/arguments.txt
echo "Gamma: $GAMMA" >> $OUT_PATH/arguments.txt
echo "SSL Type: $SSL_TYPE" >> $OUT_PATH/arguments.txt
echo "Gamma SSL: $GAMMA_SSL" >> $OUT_PATH/arguments.txt
echo "SSL Loss 1: $LOSS_SSL_1" >> $OUT_PATH/arguments.txt
echo "SSL Loss 2: $LOSS_SSL_2" >> $OUT_PATH/arguments.txt
echo "Input Directory: $INPUT_DIR" >> $OUT_PATH/arguments.txt
echo "Remarks: $REMARKS" >> $OUT_PATH/arguments.txt
echo "Starting script"
echo $(date)
python main.py \
    --input_type $INPUT_TYPE \
    --input_dir $INPUT_DIR \
    --batch_size $BATCH_SIZE \
    --process_level $PROCESS_LEVEL \
    --patience $PATIENCE \
    --num_classes $NUM_CLASSES \
    --lr $LR \
    --gamma $GAMMA \
    --weight_decay $WEIGHT_DECAY \
    --epochs $EPOCHS \
    --ssl_type $SSL_TYPE \
    --omega $OMEGA \
    --gamma_ssl $GAMMA_SSL \
    --loss_ssl_1 $LOSS_SSL_1 \
    --loss_ssl_2 $LOSS_SSL_2 \
    --out_path $OUT_PATH
cd
cp "siamdl${SLURM_JOBID}.out" $OUT_PATH
echo $(date)
