#!/bin/bash
#FLUX: --job-name=f17k_hparam
#FLUX: -c=16
#FLUX: --queue=long
#FLUX: -t=604800
#FLUX: --urgency=16

ulimit -Su unlimited
ulimit -Sv unlimited
source /home/kabhishe/.bashrc
conda activate <CONDA ENV NAME>
set -euf -o pipefail    # https://sipb.mit.edu/doc/safe-shell/
cd <PATH TO CODE DIRECTORY>
declare -a holdoutsets=(
    "expert_select"
    "random_holdout" 
    "a12" 
    "a34" 
    "a56" 
    "dermaamin" 
    "br"
)
LOGS_DIR=<INSERT LOG DIRECTORY HERE>
OUTPUT_DIR=<INSERT OUTPUT DIRECTORY HERE>
for EPOCHS in {20,50,100,200}
do
    # Iterate over both the optimizers.
    for OPTIMIZER in {"SGD","Adam"}
    do
        # Iterate over all the learning rates.
        for LR in {0.01,0.001,0.0001}
        do
            # Iterate over all the holdout sets.
            for HOLDOUT in "${holdoutsets[@]}"
            do
                #  Iterate over multiple seeds.
                for SEED in {8887..8889}
                do
                    # Create a log file for the current experiment in a new directory.
                    mkdir -p "$LOGS_DIR"/"$EPOCHS"_"$OPTIMIZER"_"$LR"
                    echo "Experiment for holdout set $HOLDOUT and seed $SEED" > "$LOGS_DIR"/"$EPOCHS"_"$OPTIMIZER"_"$LR"/"$HOLDOUT"_"$SEED".log
                    # Run the training script.
                    python hparamsearch_train.py \
                    --n_epochs $EPOCHS \
                    --optimizer $OPTIMIZER \
                    --base_lr $LR \
                    --dev_mode full \
                    --data_list_file ./SimThresh_T_A2_T_0.99_0.70_FC_T_KeepOne_Out_T_OutThresh_None_0FST_F.csv \
                    --images_dir /dev/shm/myramdisk/F17k_original/ \
                    --output_dir $OUTPUT_DIR \
                    --seed $SEED \
                    --holdout_set $HOLDOUT >> "$LOGS_DIR"/"$EPOCHS"_"$OPTIMIZER"_"$LR"/"$HOLDOUT"_"$SEED".log
                done
            done
        done
    done
done
