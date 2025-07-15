#!/bin/bash
#FLUX: --job-name=size_scal
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/u/dssc/ttarch00/myblis/lib:$LD_LIBRARY_PATH'
export OMP_PLACES='cores'
export OMP_PROC_BIND='$alloc'
export OMP_NUM_THREADS='$ncores'

echo LOADING NEEDED MODULES...
echo
module load architecture/AMD
module load mkl
module load openBLAS/0.3.21-omp
export LD_LIBRARY_PATH=/u/dssc/ttarch00/myblis/lib:$LD_LIBRARY_PATH
echo
echo COMPILING PROGRAMS FOR OPENBLAS, MKL AND BLIS ON TARGET MACHINE...
echo
datafolder=$(pwd)
cd ../..
make float data=$datafolder
make double data=$datafolder
cd $datafolder
echo
echo --------------------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------------------
echo
echo GATHERING RESULTS...
echo
ncores=64
node=EPYC
alloc=spread
export OMP_PLACES=cores
export OMP_PROC_BIND=$alloc
export OMP_NUM_THREADS=$ncores
for size in $(seq 2000 250 20000)
do
	for count in $(seq 1 1 5)
	do
		#echo -n "${ncores}," >> mkl_f.csv
		#./gemm_mkl_f.x $size $size $size
		#echo -n "${ncores},"  >> oblas_f.csv
		#./gemm_oblas_f.x $size $size $size
		#echo -n "${ncores},"  >> blis_f.csv
		#./gemm_blis_f.x $size $size $size
		#echo -n "${ncores}," >> mkl_d.csv
		#./gemm_mkl_d.x $size $size $size
		#echo -n "${ncores},"  >> oblas_d.csv
		#./gemm_oblas_d.x $size $size $size
		#echo -n "${ncores},"  >> blis_d.csv
		#./gemm_blis_d.x $size $size $size
		echo
		echo -----------
		echo
	done
done
echo
echo -------------------------------------------------------------------------------------------------------
echo -------------------------------------------------------------------------------------------------------
echo
echo REMOVING COMPILED PROGRAMS AND UNLOADING MODULES...
echo
cd ../..
make clean data=$datafolder
module purge
