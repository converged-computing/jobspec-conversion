#!/bin/bash
#FLUX: --job-name=Geoxim_IA_Inference
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_PROC_BIND='MASTER'

export OMP_PROC_BIND=MASTER
if [ -d build_scale ]; then
    rm -rf  build_scale/*
    cd build_scale
else
    mkdir build_scale
    cd build_scale
fi
cmake  -DCMAKE_BUILD_TYPE=Release ..
make -j 4 > compil_log.txt
mkdir "LR" "MLR" "nonLR"
size_list="10 100 1000 10000 100000 1000000 10000000 100000000"
folders="LR MLR nonLR"
for size in ${size_list}; do
	 numactl --physcpubind=1 --membind=0 $PWD/benchmark_scale_pt.exe $PY_MODELS_DIR"/LR_model.pt" $size 1 >  LR/log_LR_${size}.txt
	 numactl --physcpubind=1 --membind=0 $PWD/benchmark_scale_pt.exe $PY_MODELS_DIR"/MLR_model.pt"  $size 2 >  MLR/log_MLR_${size}.txt
   numactl --physcpubind=1 --membind=0  $PWD/benchmark_scale_pt.exe $PY_MODELS_DIR"/non_LR_model.pt"  $size 1 >  nonLR/log_nonLR_${size}.txt
done;
for folder in ${folders}; do
    touch ${folder}/log_out_${folder}.txt
    for size in ${size_list}; do
      line=`grep  "time_"  ${folder}/log_${folder}_${size}.txt`
      echo "$line" | tee -a ${folder}/log_out_${folder}.txt
    done;
done;
SHARED_BENCH_PY_DIR="/home/irsrvshare2/R11/xca_acai/work/kadik/simple/pytorch/scale/"
rm -rf SHARED_BENCH_PY_DIR*
cp -R ${folders} ${SHARED_BENCH_PY_DIR}
cd ..
