#!/bin/bash
#FLUX: --job-name=mldock-gnn
#FLUX: --exclusive
#FLUX: --queue=bdw18
#FLUX: -t=43200
#FLUX: --urgency=16

export PATH='/home/users/${USER}/.local/bin:${PATH}'
export PYTHONUSERBASE='/home/users/${USER}/.local'
export PY3PATH='/home/users/${USER}/.local/lib/python3.6/site-packages'
export PYTHONIOENCODING='utf8'
export PYTHONPATH='$PY3PATH:$PYTHONPATH'
export MLD_RDK_ENV_INSTALL_DIR='~/rdk_env'
export CUDA_VISIBLE_DEVICES='0'
export SCRATCH='/lus/scratch/${USER}'
export SLURM_WORKING_DIR='${TEMP_DIR}'

echo "Init..."
date
cd $SLURM_SUBMIT_DIR
module rm atp
module use /cray/css/users/dctools/modulefiles
module rm anaconda2
module load anaconda3
export PATH=/home/users/${USER}/.local/bin:${PATH}
export PYTHONUSERBASE=/home/users/${USER}/.local
export PY3PATH=/home/users/${USER}/.local/lib/python3.6/site-packages
source /cray/css/users/dctools/anaconda3/etc/profile.d/conda.sh
export PYTHONIOENCODING=utf8
export PYTHONPATH=$PY3PATH:$PYTHONPATH
export MLD_RDK_ENV_INSTALL_DIR=~/rdk_env
conda activate $MLD_RDK_ENV_INSTALL_DIR
export CUDA_VISIBLE_DEVICES=0
export SCRATCH=/lus/scratch/${USER}
MAP_TRAIN_NAME=tiny_train
MAP_TEST_NAME=tiny_test
MAP_TRAIN_PATH=/lus/scratch/avose/data/map/${MAP_TRAIN_NAME}.map
MAP_TEST_PATH=/lus/scratch/avose/data/map/${MAP_TEST_NAME}.map
NODES=1
NP=1
BS=8
LR0=0.000001
MLP_LATENT=32,32
MLP_LAYERS=2,2
GNN_LAYERS=8,8
NUM_FEATURES=16,16
MODE=classification
EPOCHS=1002
TEMP_DIR=${SCRATCH}/temp/mldock-${MAP_TRAIN_NAME}-${MAP_TEST_NAME}-np_${NP}-lr_${LR0}-${GNN_LAYERS}_layer-${MLP_LATENT}x${MLP_LAYERS}-bs_${BS}-epochs_${EPOCHS}-nf_${NUM_FEATURES}-mode_${MODE}
rm -rf $TEMP_DIR
mkdir -p ${TEMP_DIR}
cp ./train_osprey.pbs ./mldock_gnn.py ./gnn_models.py ./dataset_utils.py ./chemio.py ${TEMP_DIR}/
cd ${TEMP_DIR}
export SLURM_WORKING_DIR=${TEMP_DIR}
date
echo "Done."
echo
echo "Settings:"
pwd
ls
echo
echo "Running..."
date
time srun --pty -u -N 1 -n 1 python mldock_gnn.py \
    --map_train ${MAP_TRAIN_PATH} \
    --map_test ${MAP_TEST_PATH} \
    --batch_size ${BS} \
    --mlp_latent ${MLP_LATENT} \
    --mlp_layers ${MLP_LAYERS} \
    --gnn_layers ${GNN_LAYERS} \
    --lr_init ${LR0} \
    --num_features ${NUM_FEATURES} \
    --mode ${MODE} \
    --epochs ${EPOCHS} 2>&1 | tee train_osprey.log
date
echo "Done."
