#!/bin/bash
#FLUX: --job-name=GFP
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=302400
#FLUX: --urgency=16

HOME_DIR=/home/pcq275/
COREL_DIR=${HOME_DIR}/corel/
CONFIG=${COREL_DIR}slurm/gfp_config_corel.txt
CONDA_BASE=$(conda info --base)
source ${CONDA_BASE}/etc/profile.d/conda.sh
if [ $(cat ${CONDA_PREFIX}/etc/conda/activate.d/env_vars.sh | wc -l) == 0 ]; then
    echo 'CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
    source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
fi
seed=$(awk -v ArrayID=${SLURM_ARRAY_TASK_ID} '$1==ArrayID {print $2}' ${CONFIG})
batchsize=$(awk -v ArrayID=${SLURM_ARRAY_TASK_ID} '$1==ArrayID {print $3}' ${CONFIG})
task=$(awk -v ArrayID=${SLURM_ARRAY_TASK_ID} '$1==ArrayID {print $4}' ${CONFIG})
n_start=$(awk -v ArrayID=${SLURM_ARRAY_TASK_ID} '$1==ArrayID {print $5}' ${CONFIG})
iterations=$(awk -v ArrayID=${SLURM_ARRAY_TASK_ID} '$1==ArrayID {print $6}' ${CONFIG})
model=$(awk -v ArrayID=${SLURM_ARRAY_TASK_ID} '$1==ArrayID {print $7}' ${CONFIG})
conda activate corel-env
echo "python ${COREL_DIR}/experiments/run_cold_warm_start_experiments_gfp_bo.py -b ${batchsize} -s ${seed} -p ${task} -n ${n_start} -m ${iterations} --model ${model}"
python ${COREL_DIR}/experiments/run_cold_warm_start_experiments_gfp_bo.py -b ${batchsize} -s ${seed} -p ${task} -n ${n_start} -m ${iterations} --model ${model}
exit 0
