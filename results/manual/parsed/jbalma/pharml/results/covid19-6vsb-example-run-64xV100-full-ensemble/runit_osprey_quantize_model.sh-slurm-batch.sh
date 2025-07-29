#!/bin/bash
#FLUX: --job-name=resnet
#FLUX: --exclusive
#FLUX: --queue=spider
#FLUX: -t=3600
#FLUX: --urgency=16

export MLD_RDK_ENV_INSTALL_DIR='~/cuda10_env'
export SCRATCH='/lus/scratch/jbalma'
export CUDA_VISIBLE_DEVICES='0'
export HOROVOD_MPI_THREADS_DISABLE='1'
export HOROVOD_FUSION_THRESHOLD='0'

source ./setup_env_cuda10_quantize.sh
export MLD_RDK_ENV_INSTALL_DIR=~/cuda10_env
source activate $MLD_RDK_ENV_INSTALL_DIR
which python
export SCRATCH=/lus/scratch/jbalma
export CUDA_VISIBLE_DEVICES=0
echo "Running..."
export HOROVOD_MPI_THREADS_DISABLE=1
export HOROVOD_FUSION_THRESHOLD=0
d="$(date +%Y)-$(date +%h%m-%s)"
save_dir_name=pharml_results_quantized_${d}
ORIGINAL_MODELS_DIR=/lus/scratch/jbalma/pharml_results_5layer/ensemble_models
ENSEMBLE_MODELS=/lus/scratch/jbalma/$save_dir_name/ensemble_models
ENSEMBLE_OUTPUT=/lus/scratch/jbalma/$save_dir_name/ensemble_outputs
ENSEMBLE_RAW=/lus/scratch/jbalma/$save_dir_name/ensemble_raw_runs
echo "Starting Ensemble train/test run, saving to:"
echo " -> Model files: ${ENSEMBLE_MODELS}"
echo " -> Inference Output Values: ${ENSEMBLE_OUTPUT}"
echo " -> Raw Run Results: ${ENSEMBLE_RAW}"
list_of_models="/lus/scratch/jbalma/pharml_results_5layer/ensemble_models/model_0"
model_n=0
for f in $list_of_models
do
    MODEL_PATH_TO_QUANTIZE=$f
    MAP_TRAIN_NAME=l0_1pct_train
    MAP_TEST_NAME=bindingdb_2019m4_1of75pct
    MAP_TEST_BIG_NAME=bindingdb_2019m4_75
    MAP_TEST_ZINC_NAME=4ib4_zinc15
    MAP_TRAIN_PATH=/lus/scratch/avose/data/map/${MAP_TRAIN_NAME}.map
    MAP_TEST_PATH=/lus/scratch/avose/data/map/${MAP_TEST_NAME}.map
    MAP_TEST_BIG_PATH=/lus/scratch/avose/data/map/${MAP_TEST_BIG_NAME}.map
    MAP_TEST_ZINC_PATH=/lus/scratch/avose/data_zinc15/map/${MAP_TEST_ZINC_NAME}.map
    echo "Model number = ${model_n}"
    echo "Quantizing model from: ${MODEL_PATH_TO_QUANTIZE}"
    echo "Running with input data ${MAP_TRAIN_PATH}"
    echo "test data from: ${MAP_TEST_PATH}"
    echo "big test data from: ${MAP_TEST_BIG_PATH}"
    echo "zinc test data from: ${MAP_TEST_ZINC_PATH}"
    NODES=1 #nodes total
    PPN=1 #processer per node
    PPS=1 #processes per socket
    NP=1 #processes total
    NC=36  #job threads per rank
    NT=2  #batching threads per worker
    BS=16 #batch size per rank
    BS_TEST=32 #inference batch size
    #LR0=0.000001 #for BS=2,4,6
    LR0=0.00000001
    MLP_LATENT=32,32
    MLP_LAYERS=2,2
    GNN_LAYERS=5,5
    NUM_FEATURES=16,16
    MODE=classification
    EPOCHS=1000
    TEMP_DIR=${SCRATCH}/temp/quantized_check_model${model_n}-test_${MAP_TEST_NAME}-np-${NP}-lr${LR0}-${GNN_LAYERS}-layer-${MLP_LATENT}x${MLP_LAYERS}-bs_${BS}-epochs-${EPOCHS}-nf-${NUM_FEATURES}
    rm -rf $TEMP_DIR
    mkdir -p ${TEMP_DIR}
    cp -r -v /cray/css/users/jbalma/Innovation-Proposals/mldock/mldock-gnn/* ${TEMP_DIR}/
    cd ${TEMP_DIR}
    export SLURM_WORKING_DIR=${TEMP_DIR}
    echo
    pwd
    ls
    echo
    echo "Running Train..."
    date
    srun -C V100 -p spider -c ${NC} --hint=multithread -l -N ${NODES} -n ${NP} -u --exclusive --cpu_bind=rank_ldom --accel-bind=g,v python mldock_gnn_quantize.py \
        --map_train ${MAP_TRAIN_PATH} \
        --map_test ${MAP_TEST_PATH} \
        --batch_size ${BS} \
        --batch_size_test ${BS_TEST} \
        --mlp_latent ${MLP_LATENT} \
        --mlp_layers ${MLP_LAYERS} \
        --gnn_layers ${GNN_LAYERS} \
        --hvd True \
        --lr_init ${LR0} \
        --use_clr True \
        --plot_history True \
        --num_features ${NUM_FEATURES} \
        --data_threads ${NT} \
        --mode ${MODE} \
        --inference_only True \
        --restore="${MODEL_PATH_TO_QUANTIZE}/checkpoints/model0.ckpt" \
        --epochs ${EPOCHS} 2>&1 |& tee trainrun.out
    let "model_n=model_n+1"
done
echo "Done training/testing all monolithic-trained models"
wait
date
