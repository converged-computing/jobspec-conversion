#!/bin/bash
#FLUX: --job-name=gassy-peanut-butter-3456
#FLUX: --exclusive
#FLUX: --urgency=16

export SCRATCH='/lus/scratch/jbalma'
export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7'
export HOROVOD_MPI_THREADS_DISABLE='1'
export HOROVOD_FUSION_THRESHOLD='0'

source /cray/css/users/jbalma/bin/setup_env_cuda90_osprey_V100.sh
source /cray/css/users/jbalma/bin/env_python3.sh
module rm anaconda2
module load craype-dl-plugin-py3
which python
export SCRATCH=/lus/scratch/jbalma
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
echo "Running..."
export HOROVOD_MPI_THREADS_DISABLE=1
export HOROVOD_FUSION_THRESHOLD=0
PROF_LINE="-m cProfile -o pyprof_mldock.out"
list_of_files="bindingdb_2019m4_5of25pct_a"
model_n=0
for f in $list_of_files
do
    MAP_TRAIN_NAME=$f
    MAP_TEST_NAME=bindingdb_2019m4_1of75pct
    MAP_TRAIN_PATH=/lus/scratch/avose/data/map/${MAP_TRAIN_NAME}.map
    MAP_TEST_PATH=/lus/scratch/avose/data/map/${MAP_TEST_NAME}.map
    echo "Model number = ${model_n}"
    echo "Running with input data ${MAP_TRAIN_PATH}"
    echo "test data from: ${MAP_TEST_PATH}"
    NODES=1 #nodes total
    NP=1 #processes total
    NT=1 #threads per rank
    BS=2 #batch size per rank
    LR0=0.000001
    MLP_LATENT=32,32
    MLP_LAYERS=2,2
    GNN_LAYERS=8,8
    NUM_FEATURES=16,16
    MODE=classification
    #DATA_MODE=none,atoms+edges
    EPOCHS=2
    TEMP_DIR=${SCRATCH}/temp/cdl_ensemble${model_n}-mldock-train-${MAP_TRAIN_NAME}-test_${MAP_TEST_NAME}-np-${NP}-lr${LR0}-${GNN_LAYERS}-layer-${MLP_LATENT}x${MLP_LAYERS}-bs_${BS}-epochs-${EPOCHS}-nf-${NUM_FEATURES}_fresh
    rm -rf $TEMP_DIR
    mkdir -p ${TEMP_DIR}
    cp ./* ${TEMP_DIR}/
    cd ${TEMP_DIR}
    export SLURM_WORKING_DIR=${TEMP_DIR}
    echo
    echo "Settings:"
    pwd
    ls
    echo
    echo "Running..."
    date
    ulimit -c unlimited
    ulimit -l unlimited
    #python /path/to/core, thread apply all backtrace
    srun  --slurmd-debug=verbose --mpi=pmix --accel-bind=g,v -c 18 --hint=multithread --mem=0 -l -N ${NODES} -n ${NP} -C V100 -p spider -u --exclusive --cpu_bind=none python mldock_gnn_dlcomm2.py \
        --map_train ${MAP_TRAIN_PATH} \
        --map_test ${MAP_TEST_PATH} \
        --batch_size ${BS} \
        --mlp_latent ${MLP_LATENT} \
        --mlp_layers ${MLP_LAYERS} \
        --gnn_layers ${GNN_LAYERS} \
        --lr_init ${LR0} \
        --use_clr True \
        --hvd True \
        --num_features ${NUM_FEATURES} \
        --data_threads ${NT} \
        --mode ${MODE} \
        --epochs ${EPOCHS} 2>&1 |& tee myrun.out
    sleep 10
    echo "done with $model_n"
    let "model_n=model_n+1"
done
date
echo "Done..."
