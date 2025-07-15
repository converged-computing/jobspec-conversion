#!/bin/bash
#FLUX: --job-name=milky-salad-1722
#FLUX: --queue=draco
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH'
export PATH='$PATH'

set -euxo pipefail
HOST=$(hostname)
MACHINE=${HOST}_${SLURM_CPUS_ON_NODE}
EXP_ID=cpu_aa_tp2
CODE_DIR=$1
EXP_DIR=$CODE_DIR/labbook/cpu
EXP_NAME=${EXP_ID}_${MACHINE}
cd $SCRATCH
rm -rf *
mkdir $EXP_NAME
pushd $EXP_NAME
CUDA_INSTALLATION=/usr/local/cuda-10.1
LD_LIBRARY_PATH+=:${CUDA_INSTALLATION}/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
PATH+=:${CUDA_INSTALLATION}/bin
export PATH=$PATH
cp -r $CODE_DIR code
mkdir results
results_csv=$(readlink -f results/${EXP_NAME}.csv)
results_dir=$(readlink -f results)
pushd code
make CUDA_OPT=NVIDIA CUDA_PATH=$CUDA_INSTALLATION
echo "id,method,instance,time" > $results_csv
while read -r id method instance; do
    csv_line=${id},${method},${instance}
    echo
    echo "--> Running with params: $id $method $instance"
    log_file=$results_dir/${id}_${method}_${instance}.log
    ./build/gsg cpu $method data/$instance > $log_file
    time_obs=$(grep '^time' $log_file | awk '{print $2}')
    echo ${csv_line},${time_obs} >> $results_csv
done < $EXP_DIR/runs.plan
popd
tar czf $EXP_DIR/data/$EXP_NAME.tar.gz *
popd
rm -rf $SCRATCH/*
