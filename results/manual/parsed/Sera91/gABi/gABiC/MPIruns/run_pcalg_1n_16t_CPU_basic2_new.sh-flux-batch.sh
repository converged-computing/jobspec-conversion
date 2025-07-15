#!/bin/bash
#FLUX: --job-name=pc-dask-1node
#FLUX: --queue=regular2
#FLUX: -t=600
#FLUX: --urgency=16

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
Nsample=(1000 2000 4000)
for N in "${Nsample[@]}"
do
    cp params_pc_basic_$N.py params_pc_basic.py
    mpirun -n 16 python parallel_pc_basic_dataset2.py > output_1node_16t_CPU_MIRRI_GBN_${N}_new.txt
done
