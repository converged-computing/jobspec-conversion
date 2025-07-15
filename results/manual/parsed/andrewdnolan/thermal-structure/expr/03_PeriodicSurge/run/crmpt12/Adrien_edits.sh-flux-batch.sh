#!/bin/bash
#FLUX: --job-name=dask_gridding
#FLUX: -c=32
#FLUX: -t=7200
#FLUX: --priority=16

export NUM_WORKERS='32'
export THREADS_PER_WORKER='1'

export NUM_WORKERS=32
export THREADS_PER_WORKER=1
source ../../config/modulefile.cc.cedar
source ./periodic_surge.sh
KEY='crmpt12'
create_dask_cluster
run_name="crmpt12_dx_50_TT_9000.0_MB_-0.37_OFF_Tma_-8.5_B_1.000e-04_SP_2_QP_28"
new_name="crmpt12_dx_50_TT_0--9ka_MB_-0.37_OFF_Tma_-8.5_B_1.000e-04_SP_2_QP_28"
mv "result/${KEY}/mesh_dx50/${run_name}.result"\
    "result/${KEY}/mesh_dx50/${new_name}.result"
mv "result/${KEY}/nc/${run_name}.nc"\
    "result/${KEY}/nc/${new_name}.nc"
run_name="${new_name}"
post_proccess
