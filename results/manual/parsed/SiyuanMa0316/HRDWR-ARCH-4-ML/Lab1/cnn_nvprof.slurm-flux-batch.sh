#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: --queue=gtx
#FLUX: -t=10800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/apps/cuda10_1/lib64'

module load intel/18.0.2 python3/3.7.0
module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/apps/cuda10_1/lib64
source $WORK/Lab1B_virtualenv/bin/activate
mkdir -p $WORK/Lab1B/output
home_path=$WORK/HRDWR-ARCH-4-ML/Lab1
output_path=${home_path}/output_nvprof
mkdir -p ${output_path}
for code in 1 10 1101
do
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_executed --openacc-profiling off --metrics inst_executed python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_ipc --openacc-profiling off --metrics ipc python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_control --openacc-profiling off --metrics inst_control python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_integer --openacc-profiling off --metrics inst_integer python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_fp_64 --openacc-profiling off --metrics inst_fp_64 python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_fp_32 --openacc-profiling off --metrics inst_fp_32 python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_cf_fu_utilization --openacc-profiling off --metrics cf_fu_utilization python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_double_precision_fu_utilization --openacc-profiling off --metrics double_precision_fu_utilization python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_special_fu_utilization --openacc-profiling off --metrics special_fu_utilization python3 ${home_path}/cnn_keras.py ${code}
    #nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_single_precision_fu_utilization --openacc-profiling off --metrics single_precision_fu_utilization python3 ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_dram_read_transactions --metrics dram_read_transactions python ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_dram_write_transaction --metrics dram_write_transaction python3 ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_executed_global_loads --metrics inst_executed_global_loads python3 ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_executed_local_loads --metrics inst_executed_local_loads python3 ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_executed_shared_loads --metrics inst_executed_shared_loads python3 ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_executed_surface_loads --metrics inst_executed_surface_loads python3 ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_executed_global_stores --metrics inst_executed_global_stores python3 ${home_path}/cnn_keras.py ${code}
    # nvprof --csv --log-file ${output_path}/cnn_nvprof_${code}_inst_executed_local_stores --metrics inst_executed_local_stores python3 ${home_path}/cnn_keras.py ${code}
    nvprof --csv --log-file ${output_path}/mlp_nvprof_${code}_dram_read_throughput --openacc-profiling off --metrics dram_read_throughput python3 ${home_path}/mlp_keras.py ${code}
    nvprof --csv --log-file ${output_path}/mlp_nvprof_${code}_stall_memory_throttle --openacc-profiling off --metrics stall_memory_throttle python3 ${home_path}/mlp_keras.py ${code}
done
