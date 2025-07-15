#!/bin/bash
#FLUX: --job-name=persnickety-kerfuffle-1393
#FLUX: --priority=16

export num_dev='`echo $CUDA_VISIBLE_DEVICES | awk 'BEGIN{FS=","};{print NF}'`'
export init='step3_charmm2amber'
export pstep='step4.0_minimization'
export istep='step4.1_equilibration'

ml purge  > /dev/null 2>&1 
ml GCC/7.3.0-2.30  CUDA/9.2.88  OpenMPI/3.1.1
ml Amber/18-AmberTools-18-patchlevel-10-8 
nvidia-smi
export num_dev=`echo $CUDA_VISIBLE_DEVICES | awk 'BEGIN{FS=","};{print NF}'`
echo $num_dev
export init="step3_charmm2amber"
export pstep="step4.0_minimization"
export istep="step4.1_equilibration"
pmemd.cuda -O -i ${istep}.mdin -p ${init}.parm7 -c ${pstep}.rst7 -o ${istep}.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -ref ${init}.rst7 -x ${istep}.nc
exit 0
