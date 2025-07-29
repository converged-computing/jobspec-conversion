#!/bin/bash
#FLUX: --job-name=Geoxim_IA_Inference
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_PROC_BIND='MASTER'

export OMP_PROC_BIND=MASTER
if [ -d build_mpi ]; then
    rm -rf  build_mpi/*
    cd build_mpi
else
    mkdir build_mpi
    cd build_mpi
fi
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j 4 > compil_log.txt
mkdir "nonLR"
NP_LIST="1 2 4 8 12 16 20 24 30 36"
folders="nonLR"
for NP in ${NP_LIST}; do
  PROC=$(($NP-1))
	mpirun -genv I_MPI_PIN_PROCESSOR_LIST=0-$PROC -np $NP ./benchmark_mpi_onnx.exe  "../../src_python/non_LR_model.onnx" 99532800 1 10 >  nonLR/log_$NP.txt
done;
for folder in ${folders}; do
  touch ${folder}/duration_predict.txt
  for NP in ${NP_LIST}; do
    # duration_predict
    line=`grep  "duration_predict_*"  ${folder}/log_$NP.txt`
    echo "$line" | tee -a ${folder}/duration_predict.txt
  done;
done;
SHARED_BENCH_PY_DIR="/home/irsrvshare2/R11/xca_acai/work/kadik/simple/onnx/mpi/"
rm -rf SHARED_BENCH_PY_DIR*
cp -R ${folders} ${SHARED_BENCH_PY_DIR}
cd ..
