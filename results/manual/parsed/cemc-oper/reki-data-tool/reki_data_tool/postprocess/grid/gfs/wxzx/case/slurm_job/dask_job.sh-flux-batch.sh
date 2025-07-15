#!/bin/bash
#FLUX: --job-name=blank-arm-9277
#FLUX: --priority=16

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export PYTHONUNBUFFERED='1'
export PYTHONPATH='/g11/wangdp/project/work/data/nwpc-data/reki-data-tool:/g11/wangdp/project/work/data/nwpc-data/reki:$PYTHONPATH'

set -x
unset GRIB_DEFINITION_PATH
echo "script start..."
date
JOB_ID=${SLURM_JOB_ID:-0}
echo "job id: ${JOB_ID}"
echo "load anaconda3..."
date
. /g1/u/wangdp/start_anaconda3.sh
echo "load nwpc-data..."
date
conda activate py311-data
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHONUNBUFFERED=1
ulimit -s unlimited
echo "enter work directory..."
work_directory=/g11/wangdp/project/work/data/playground/operation/gfs/wxzx/output/11-dask-v1
test -d ${work_directory} || mkdir -p ${work_directory}
cd ${work_directory}
echo "run script..."
date
export PYTHONPATH=/g11/wangdp/project/work/data/nwpc-data/reki-data-tool:/g11/wangdp/project/work/data/nwpc-data/reki:$PYTHONPATH
mpirun python -m reki_data_tool.postprocess.grid.gfs.wxzx dask-v1 \
  --engine=mpi \
  --input-file-path=/g0/nwp_pd/NWP_CMA_GFS_GMF_POST_V2023_DATA/2022090100/togrib2/output/grib2_orig/gmf.gra.2022090100015.grb2 \
  --output-file-path /g11/wangdp/project/work/data/playground/operation/gfs/wxzx/output/11-dask-v1/wxzx-dask-v1-gfs-4-0-2022090100-015.grib2
echo "script done"
date
set +x
