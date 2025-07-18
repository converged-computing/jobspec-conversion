#!/bin/bash
#FLUX: --job-name=ovemdd
#FLUX: -n=4
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

export TLRMDCROOT='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/TLR-MDC'
export TLRMVMROOT='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/lib'
export PYTLRROOT='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/python'
export PYTHONPATH='$PYTHONPATH:$TLRMDCROOT:$TLRMVMROOT:$PYTLRROOT'
export PYTHONDONTWRITEBYTECODE='1 # disable generation of __pycache__ folder'
export STORE_PATH='/ibex/ai/home/ravasim/MDC-TLRMVM/'
export FIG_PATH='/home/ravasim/2022/Projects/MDC_TLRMVM_v2/Figs'

module load intel/2022.3 gcc/11.3.0 openmpi/4.1.4/gnu11.2.1-cuda11.8 cmake/3.24.2/gnu-11.2.1 cuda/11.8
source /home/ravasim/miniconda3/bin/activate mdctlrenv
export TLRMDCROOT=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/TLR-MDC
export TLRMVMROOT=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/lib
export PYTLRROOT=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/tlrmvm-dev/build/install/python
export PYTHONPATH=$PYTHONPATH:$TLRMDCROOT:$TLRMVMROOT:$PYTLRROOT
export PYTHONDONTWRITEBYTECODE=1 # disable generation of __pycache__ folder
export STORE_PATH=/ibex/ai/home/ravasim/MDC-TLRMVM/
export FIG_PATH=/home/ravasim/2022/Projects/MDC_TLRMVM_v2/Figs
mpirun -np 4 python $TLRMDCROOT/app/MDDOve3DFull.py --AuxFile MDDOve3D_aux.npz --DataFolder compresseddata_full \
--M 26040 --N 15930 --MVMType TLR --TLRType fp32 \
--nb 256 --threshold 0.001 --ModeValue 8 --OrderType hilbert --PHilbertSrc 12 --PHilbertRec 12 --nfmax 200 --vs 9115 --debug
