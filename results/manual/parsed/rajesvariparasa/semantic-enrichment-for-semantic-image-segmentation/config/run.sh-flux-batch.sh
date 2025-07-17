#!/bin/bash
#FLUX: --job-name=buttery-bike-1307
#FLUX: --queue=shortrun
#FLUX: -t=108000
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
cd scripts
INPUT_TYPE="siam_96"
INPUT_DIR="/share/projects/siamdl/data/small/"
OUT_PATH="/share/projects/siamdl/outputs/${SLURM_JOBID}_$(date +%Y%m%d)_$INPUT_TYPE/quickview/"
BATCH_SIZE=16
PROCESS_LEVEL="l1c"
LEARN_TYPE="csl"
PATIENCE=80
NUM_CLASSES=11
LR=0.0001
GAMMA=0.95
WEIGHT_DECAY=1e-7
EPOCHS=80
ENCODER_NAME="resnet50"
REMARKS="Increased epochs and gamma to 0.95. Encoder change."
mkdir -p $OUT_PATH
echo "Arguments passed to the script:" > $OUT_PATH/arguments.txt
echo "Input Directory: $INPUT_DIR" >> $OUT_PATH/arguments.txt
echo "Output Path: $OUT_PATH" >> $OUT_PATH/arguments.txt
echo "Input Type: $INPUT_TYPE" >> $OUT_PATH/arguments.txt
echo "Batch Size: $BATCH_SIZE" >> $OUT_PATH/arguments.txt
echo "Process Level: $PROCESS_LEVEL" >> $OUT_PATH/arguments.txt
echo "Learn Type: $LEARN_TYPE" >> $OUT_PATH/arguments.txt
echo "Patience: $PATIENCE" >> $OUT_PATH/arguments.txt
echo "Number of Classes: $NUM_CLASSES" >> $OUT_PATH/arguments.txt
echo "Learning Rate: $LR" >> $OUT_PATH/arguments.txt
echo "Gamma: $GAMMA" >> $OUT_PATH/arguments.txt
echo "Weight Decay: $WEIGHT_DECAY" >> $OUT_PATH/arguments.txt
echo "Epochs: $EPOCHS" >> $OUT_PATH/arguments.txt
echo "Encoder Name: $ENCODER_NAME" >> $OUT_PATH/arguments.txt
echo "Remarks: $REMARKS" >> $OUT_PATH/arguments.txt
echo "Starting script"
echo $(date)
python main.py \
    --input_dir $INPUT_DIR \
    --out_path $OUT_PATH \
    --input_type $INPUT_TYPE \
    --batch_size $BATCH_SIZE \
    --process_level $PROCESS_LEVEL \
    --learn_type $LEARN_TYPE \
    --patience $PATIENCE \
    --num_classes $NUM_CLASSES \
    --lr $LR \
    --gamma $GAMMA \
    --weight_decay $WEIGHT_DECAY \
    --epochs $EPOCHS \
    --encoder_name $ENCODER_NAME
cd
cp "siamdl${SLURM_JOBID}.out" $OUT_PATH
echo $(date)
