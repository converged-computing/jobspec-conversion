#!/bin/bash
#FLUX: --job-name=chunky-leader-2259
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --priority=16

export TLRMDCROOT='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/TLR-MDC'
export TLRMVMROOT='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/lib'
export PYTLRROOT='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/python'
export PYTHONPATH='$PYTHONPATH:$TLRMDCROOT:$TLRMVMROOT:$PYTLRROOT'
export PYTHONDONTWRITEBYTECODE='1 # disable generation of __pycache__ folder'
export STORE_PATH='/ibex/ai/home/ravasim/ravasim_OLDscratch/MDC-TLRMVM/'
export FIG_PATH='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/Figs'

module load intel/2022.3 gcc/11.3.0 openmpi/4.1.4/gnu11.2.1-cuda11.8 cmake/3.24.2/gnu-11.2.1 cuda/11.8
source /home/ravasim/miniconda3/bin/activate mdctlrenv
export TLRMDCROOT=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/TLR-MDC
export TLRMVMROOT=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/lib
export PYTLRROOT=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/python
export PYTHONPATH=$PYTHONPATH:$TLRMDCROOT:$TLRMVMROOT:$PYTLRROOT
export PYTHONDONTWRITEBYTECODE=1 # disable generation of __pycache__ folder
export STORE_PATH=/ibex/ai/home/ravasim/ravasim_OLDscratch/MDC-TLRMVM/
export FIG_PATH=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/Figs
mpirun -np 4 python $TLRMDCROOT/app/MDD.py --AuxFile 3DMDD_aux.npz --M 9801 --N 2911 --MVMType Dense \
  --nfmax 150 --ivsinv 880 --debug
mpirun -np 4 python $TLRMDCROOT/app/MDD.py --AuxFile 3DMDD_aux.npz --M 9801 --N 2911 --MVMType TLR --TLRType fp16 \
  --nb 128 --ModeValue 4 --OrderType normal --nfmax 150 --ivsinv 880 --debug
