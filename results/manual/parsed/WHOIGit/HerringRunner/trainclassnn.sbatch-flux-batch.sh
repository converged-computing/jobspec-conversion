#!/bin/bash
#FLUX: --job-name=trainclassnn
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Job ID: $SLURM_JOB_ID, JobName: $SLURM_JOB_NAME"
echo "Command: $0 $@"
hostname; pwd; date; echo "CUDA=$CUDA_VISIBLE_DEVICES"
module load cuda10.1/{toolkit,blas,fft,cudnn}
source herring_classnn_env/bin/activate
echo "Environment... Loaded"
set -eux
DATASET_CFG=$1   # eg training-data/lists/EXAMPLE_DIR
MODEL=$2         # eg inception_v3
MODEL_ID="${DATASET_CFG}__${MODEL}__COUNTS_MODE"
cd pytorch_classifier 
echo; echo "TRAINING START"
time python neuston_net.py TRAIN $MODEL  ../${DATASET_CFG}/training.txt ../${DATASET_CFG}/validation.txt ${MODEL_ID} --outdir ../training-output/{$MODEL_ID} --estop 20 --emax 200 --counts-mode
if [ "$#" -eq 3 ]; then
    TESTDATA=$3
    echo; echo "TESTSET DETECT"    
    time python neuston_net.py RUN "../$TESTDATA" "../training-output/$MODEL_ID/$MODEL_ID.ptl" ${MODEL_ID}__TESTSET_RESULTS --outdir ../training-output/$MODEL_ID/testset_results --outfile img_results.csv
fi
echo; echo Job ID: $SLURM_JOB_ID is DONE!
