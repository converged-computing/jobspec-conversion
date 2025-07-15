#!/bin/bash
#FLUX: --job-name=hanky-destiny-8157
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
mkdir "LR" "MLR" "nonLR"
NP_LIST="1 2 3 4 5 6 7 8"
folders="LR MLR nonLR"
for NP in ${NP_LIST}; do
  PROC=$(($NP-1))
	mpirun -genv I_MPI_PIN_PROCESSOR_LIST=0-$PROC -np $NP ./benchmark_mpi_pt.exe 4032000 "../../models/LR_model.pt" 1 10 >  LR/log_$NP.txt
	mpirun -genv I_MPI_PIN_PROCESSOR_LIST=0-$PROC -np $NP ./benchmark_mpi_pt.exe 4032000 "../../models/MLR_model.pt" 2 10 >  MLR/log_$NP.txt
	mpirun -genv I_MPI_PIN_PROCESSOR_LIST=0-$PROC -np $NP ./benchmark_mpi_pt.exe 4032000 "../../models/non_LR_model.pt" 1 10 >  nonLR/log_$NP.txt
done;
for folder in ${folders}; do
  touch ${folder}/duration_scatter.txt ${folder}/duration_convert_to_tensor.txt ${folder}/duration_predict.txt
  touch ${folder}/duration_convert_to_array.txt ${folder}/duration_gather.txt
  for NP in ${NP_LIST}; do
    # duration_scatter
    line=`grep  "duration_scatter"  ${folder}/log_$NP.txt`
    echo "$NP $line" | tee -a ${folder}/duration_scatter.txt
    # duration_convert_to_tensor
    line=`grep  "duration_convert_to_tensor"  ${folder}/log_$NP.txt`
    echo "$NP $line" | tee -a ${folder}/duration_convert_to_tensor.txt
    # duration_predict
    line=`grep  "duration_predict_*"  ${folder}/log_$NP.txt`
    echo "$line" | tee -a ${folder}/duration_predict.txt
    # duration_convert_to_array
    line=`grep  "duration_convert_to_array"  ${folder}/log_$NP.txt`
    echo "$NP $line" | tee -a ${folder}/duration_convert_to_array.txt
    # duration_gather
    line=`grep  "duration_gather"  ${folder}/log_$NP.txt`
    echo "$NP $line" | tee -a ${folder}/duration_gather.txt
  done;
done;
SHARED_BENCH_PY_DIR="/home/irsrvshare2/R11/xca_acai/work/kadik/simple/pytorch/mpi/"
rm -rf SHARED_BENCH_PY_DIR*
cp -R ${folders} ${SHARED_BENCH_PY_DIR}
cd ..
