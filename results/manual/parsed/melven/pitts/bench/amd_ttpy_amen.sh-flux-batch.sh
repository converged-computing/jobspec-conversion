#!/bin/bash
#FLUX: --job-name=arid-train-3108
#FLUX: -c=64
#FLUX: --queue=amd
#FLUX: -t=180000
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:~/pitts/build_gcc_amd/src/:~/pitts/examples/'
export PYTHONUNBUFFERED='1'
export OMP_STACKSIZE='100M'
export LD_PRELOAD='/scratch/spack-23.2/opt/spack/linux-ubuntu20.04-x86_64_v3/gcc-9.4.0/intel-oneapi-mkl-2023.2.0-sjzhwtp2v6vh5nrppzeijqna3l6cn3ww/mkl/2023.2.0/lib/intel64/libmkl_rt.so:/scratch/spack-23.2/opt/spack/linux-ubuntu20.04-x86_64_v3/gcc-9.4.0/intel-oneapi-mkl-2023.2.0-sjzhwtp2v6vh5nrppzeijqna3l6cn3ww/lib/intel64/libmkl_intel_thread.so:/scratch/spack-23.2/opt/spack/linux-ubuntu20.04-x86_64_v3/gcc-9.4.0/intel-oneapi-mkl-2023.2.0-sjzhwtp2v6vh5nrppzeijqna3l6cn3ww/lib/intel64/libmkl_core.so:$LD_PRELOAD'

export PYTHONPATH=$PYTHONPATH:~/pitts/build_gcc_amd/src/:~/pitts/examples/
export PYTHONUNBUFFERED=1
ulimit -s unlimited
export OMP_STACKSIZE=100M
export LD_PRELOAD=/scratch/spack-23.2/opt/spack/linux-ubuntu20.04-x86_64_v3/gcc-9.4.0/intel-oneapi-mkl-2023.2.0-sjzhwtp2v6vh5nrppzeijqna3l6cn3ww/mkl/2023.2.0/lib/intel64/libmkl_rt.so:/scratch/spack-23.2/opt/spack/linux-ubuntu20.04-x86_64_v3/gcc-9.4.0/intel-oneapi-mkl-2023.2.0-sjzhwtp2v6vh5nrppzeijqna3l6cn3ww/lib/intel64/libmkl_intel_thread.so:/scratch/spack-23.2/opt/spack/linux-ubuntu20.04-x86_64_v3/gcc-9.4.0/intel-oneapi-mkl-2023.2.0-sjzhwtp2v6vh5nrppzeijqna3l6cn3ww/lib/intel64/libmkl_core.so:$LD_PRELOAD
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank  5
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 10
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 15
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 20
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 25
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 30
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 35
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 40
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 45
srun taskset -c 0-127 likwid-pin -c 0-63 python ttpy_amen.py -n 50 -d 10 --rhs_random_rank 50
