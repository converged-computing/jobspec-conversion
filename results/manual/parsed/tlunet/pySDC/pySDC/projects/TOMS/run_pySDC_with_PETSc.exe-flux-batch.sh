#!/bin/bash
#FLUX: --job-name=lovely-arm-3873
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --urgency=16

export LD_PRELOAD='$EBROOTIMKL/mkl/lib/intel64/libmkl_def.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_avx2.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_core.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_intel_lp64.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_intel_thread.so:$EBROOTIMKL/lib/intel64/libiomp5.so'
export PYTHONPATH='$PYTHONPATH:/p/project/ccstma/cstma000/pySDC'

export LD_PRELOAD=$EBROOTIMKL/mkl/lib/intel64/libmkl_def.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_avx2.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_core.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_intel_lp64.so:$EBROOTIMKL/mkl/lib/intel64/libmkl_intel_thread.so:$EBROOTIMKL/lib/intel64/libiomp5.so
export PYTHONPATH=$PYTHONPATH:/p/project/ccstma/cstma000/pySDC
srun python pySDC_with_PETSc.py 1
touch ready
