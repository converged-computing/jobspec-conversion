#!/bin/bash
#FLUX: --job-name=butterscotch-taco-6957
#FLUX: -c=8
#FLUX: --queue=seas_gpu
#FLUX: -t=604800
#FLUX: --urgency=16

module load python/3.10.12-fasrc01
module load gcc/12.2.0-fasrc01
module load cuda/12.0.1-fasrc01
module load cudnn/8.9.2.26_cuda12-fasrc01
module load cmake
HOME_DIR="/n/holylabs/LABS/idreos_lab/Users/azhao"
SCRIPT_DIR=$HOME_DIR/gpu_profiling/scripts
DATA_DIR="/n/holyscratch01/idreos_lab/Users/azhao/linear_data"
FILE=$DATA_DIR/$1
mamba activate $HOME_DIR/env
sizes=(1 2 $(seq 4 4 124) $(seq 128 8 248) $(seq 256 16 368) $(seq 384 32 480) $(seq 512 64 1024))
precisions=(161 162 32)
biases=(0 1)
FINAL_CSV=$HOME_DIR/gpu_profiling/data/linear.$1.csv # Avoid race conditions.
if [ ! -f "$FINAL_CSV" ]; then
    touch "$FINAL_CSV"
fi
for precision in "${precisions[@]}"
do
    for bias in "${biases[@]}"
    do
        echo "$precision, $bias--------------" # For some sanity checking.
        for in_size in "${sizes[@]}"
        do
            for out_size in "${sizes[@]}"
            do
                # Run ncu and export into CSV format for preprocessing.
                ncu --nvtx --nvtx-include "profile_range/" --set full \
                    -f --export $FILE --target-processes all \
                    $HOME_DIR/env/bin/python3 $SCRIPT_DIR/profile_linear.py \
                    $1 $precision $bias $in_size $out_size
                ncu --import $FILE.ncu-rep --csv > $FILE.csv
                # Process the CSV.
                $HOME_DIR/env/bin/python3 \
                    $SCRIPT_DIR/parse_ncu.py $FILE.csv $FINAL_CSV $1 $precision $bias $in_size $out_size
            done
        done
    done
done
rm $FILE.ncu-rep
rm $FILE.csv
