#!/bin/bash
#FLUX: --job-name=jac_mod
#FLUX: -c=20
#FLUX: --queue=akya-cuda
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='${CPU_THREADS}'

echo "SLURM NODELIST $SLURM_NODELIST"
echo "NUMBER OF SLURM CORES $SLURM_NTASKS"
module purge 
module load centos7.3/comp/cmake/3.18.0
module load centos7.3/comp/gcc/7
module load centos7.3/lib/cuda/10.1
source /truba/home/aalabsialjundi/anaconda3/bin/activate
conda init
JOB_ID=${SLURM_JOB_ID}
JACCARD_PATH=/truba/home/aalabsialjundi/Jaccard-ML/
DATA_PATH=/truba/home/aalabsialjundi/graphs/
EXPERIMENT_PARAMS=${JACCARD_PATH}/parameters/experiment.json
AVG=10
OUTPUT_FILE=model
CPU_THREADS=20
NODE="$(echo -e "${SLURM_NODELIST}" | tr -d '[:space:]')"
RES_PATH=${NODE}/
BUILD_FOLDER=${JACCARD_PATH}/build
        #com-amazon_c.graph
        #com-dblp_c.graph
GRAPHS=(
        com-friendster_c.graph
        com-lj_c.graph
        com-orkut_c.graph
        flickr_c.graph
        hyperlink2012_c.graph
        indochina-2004_c.graph
        REDDIT-MULTI-12k_c.graph
        soc-LiveJournal_c.graph
        soc-sinaweibo_c.graph
        twitter_rv_c.graph
        uk-2002_c.graph
        wb-edu_c.graph
        wiki-topcats_c.graph
        youtube_c.graph
       )
export OMP_NUM_THREADS=${CPU_THREADS}
echo "Using ${CPU_THREADS} threads"
mkdir ${BUILD_FOLDER}
cd ${BUILD_FOLDER}
cmake ${JACCARD_PATH} -D_CPU=OFF
make
mkdir ${RES_PATH}
for G in ${GRAPHS[*]}
  do
    srun ./jaccard -i ${DATA_PATH}${G} -e ${EXPERIMENT_PARAMS} -a ${AVG} -j ${RES_PATH}${G}-j${SLURM_JOB_ID}-n${NODE}-avg${AVG}-th${CPU_THREADS}-ex_${EXEC}-${OUTPUT_FILE}.json
    echo "srun ./jaccard -i ${DATA_PATH}${G} -e ${EXPERIMENT_PARAMS} -a ${AVG} -j ${RES_PATH}${G}-j${SLURM_JOB_ID}-n${NODE}-avg${AVG}-th${CPU_THREADS}-ex_${EXEC}-${OUTPUT_FILE}.json"
  done
