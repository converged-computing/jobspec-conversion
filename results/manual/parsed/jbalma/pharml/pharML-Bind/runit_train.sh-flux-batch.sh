#!/bin/bash
#FLUX: --job-name=resnet
#FLUX: --exclusive
#FLUX: --priority=16

export MLD_RDK_ENV_INSTALL_DIR='/home/users/jbalma/cuda10_env_pharml'
export SCRATCH='/lus/scratch/jbalma'
export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7'
export HOROVOD_MPI_THREADS_DISABLE='1'

unset PYTHONPATH
source /cray/css/users/jbalma/bin/setup_env_cuda10_osprey_V100.sh
source /cray/css/users/jbalma/bin/env_python3.sh
export MLD_RDK_ENV_INSTALL_DIR=/home/users/jbalma/cuda10_env_pharml
source activate $MLD_RDK_ENV_INSTALL_DIR
pip install networkx --upgrade
pip install timeit
which python
export SCRATCH=/lus/scratch/jbalma
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
echo "Running..."
export HOROVOD_MPI_THREADS_DISABLE=1
d="$(date +%Y)-$(date +%h%m-%s)"
list_of_files="l0_1pct_train"
model_n=0
for f in $list_of_files
do
    MAP_TRAIN_NAME=$f
    MAP_TEST_NAME="l0_1pct_test"
    MAP_TRAIN_PATH=/lus/scratch/jbalma/avose_backup/data/map/${MAP_TRAIN_NAME}.map
    #MAP_TRAIN_PATH=/lus/scratch/jbalma/data/mldock/tools/${MAP_TRAIN_NAME}.map
    MAP_TEST_PATH=/lus/scratch/jbalma/avose_backup/data/map/${MAP_TEST_NAME}.map
    #MAP_TEST_PATH=/lus/scratch/jbalma/data/mldock/tools/${MAP_TEST_NAME}.map
    echo "Running with input data ${MAP_TRAIN_PATH}"
    echo "test data from: ${MAP_TEST_PATH}"
    NODES=1 #nodes total
    PPN=1 #processer per node
    PPS=4 #processes per socket
    NP=1 #processes total
    NC=9  #job threads per rank
    NT=2  #batching threads per worker
    BS=5 #batch size per rank
    BS_TEST=5 #inference batch size
    #LR0=0.000001 #for BS=2,4,6
    LR0=0.000000001
    MLP_LATENT=32,32
    MLP_LAYERS=2,2
    GNN_LAYERS=5,5
    NUM_FEATURES=16,16
    MODE=classification
    EPOCHS=100
    #if [ $model_n -gt 2 ]
    #then
    #    let "BS=BS/2"
    #fi
    TEMP_DIR=${SCRATCH}/temp/latest-pharmlactive-train-${MAP_TRAIN_NAME}-test_${MAP_TEST_NAME}-np-${NP}-lr${LR0}-${GNN_LAYERS}-layer-${MLP_LATENT}x${MLP_LAYERS}-bs_${BS}-epochs-${EPOCHS}-nf-${NUM_FEATURES}_fresh
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
    time srun -x spider-0002 -c ${NC} --hint=multithread -C V100 -p spider -l -N ${NODES} -n ${NP} --ntasks-per-node=${PPN} --ntasks-per-socket=${PPS} -u --exclusive --cpu_bind=rank_ldom --accel-bind=g,v python mldock_gnn.py \
        --map_train ${MAP_TRAIN_PATH} \
        --map_test ${MAP_TEST_PATH} \
        --batch_size ${BS} \
        --batch_size_test ${BS_TEST} \
        --mlp_latent ${MLP_LATENT} \
        --mlp_layers ${MLP_LAYERS} \
        --gnn_layers ${GNN_LAYERS} \
        --lr_init ${LR0} \
        --use_clr True \
        --hvd True \
        --plot_history True \
        --num_features ${NUM_FEATURES} \
        --data_threads ${NT} \
        --mode ${MODE} \
        --epochs ${EPOCHS} 2>&1 |& tee trainrun.out
done
echo "Done training"
wait
date
