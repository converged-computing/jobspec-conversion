#!/bin/bash
#FLUX: --job-name=kpc-dask-2node
#FLUX: -N=2
#FLUX: --queue=gpu2
#FLUX: -t=3600
#FLUX: --priority=16

export PATH='/home/sdigioia/R/bin:${PATH}'
export LD_LIBRARY_PATH='/home/sdigioia/R/lib64/R/lib:${LD_LIBRARY_PATH}'
export PKG_CONFIG_PATH='/home/sdigioia/R/lib64/pkgconfig/:${PKG_CONFIG_PATH}'

module purge
module load gnu11 openmpi3  gsl cuda/11.0 #to modify
source /home/sdigioia/.bashrc
conda activate py310-ul
PATH="/home/sdigioia/R/bin:$PATH"
export PATH=/home/sdigioia/R/bin:${PATH}
export LD_LIBRARY_PATH=/home/sdigioia/R/lib64/R/lib:${LD_LIBRARY_PATH}
export PKG_CONFIG_PATH=/home/sdigioia/R/lib64/pkgconfig/:${PKG_CONFIG_PATH}
Nsample=(2000 5000)
for N in "${Nsample[@]}"
do
    cp params_basic_$N.py params_basic.py
    mpirun -n 6 python parallel_kpcalg_mpi_basic_dataset2.py > output_2nodes_HSIC_GPU_basic_dataset_${N}_new.txt
done
