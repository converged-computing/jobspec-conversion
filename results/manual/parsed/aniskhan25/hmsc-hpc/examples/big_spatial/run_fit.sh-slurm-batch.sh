#!/bin/bash
#FLUX: --job-name=hmsc-hpc_fit
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

ind=$SLURM_ARRAY_TASK_ID
MT=${1:-0}
SAM=${2:-100}
THIN=${3:-10}
module load tensorflow/2.14
hostname
modelTypeStringSuffices=("ns" "fu" "pg" "nn" "ph")
modelTypeString="$MT${modelTypeStringSuffices[$MT]}"
nsVec=(10 20 40 80 160 320 622)
nyVec=(100 200 400 800 1600 3200 6400 12800 25955)
ns=${nsVec[$(($ind / 100 - 1))]}
ny=${nyVec[$(($ind % 100 - 1))]}
nChains=1
data_path="/scratch/project_1234567/username/hmsc_hpc/examples/big_spatial"
input_path=$data_path/$(printf "init/init_%s_ns%.3d_ny%.5d_chain%.2d.rds" $modelTypeString $ns $ny $nChains)
output_path=$data_path/$(printf "fmTF/TF_%s_ns%.3d_ny%.5d_chain%.2d_sam%.4d_thin%.4d.rds" $modelTypeString $ns $ny $nChains $SAM $THIN)
srun python3 -m hmsc.run_gibbs_sampler --input $input_path --output $output_path --samples $SAM --transient $(($SAM*$THIN)) --thin $THIN --verbose 100 
