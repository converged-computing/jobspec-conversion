#!/bin/bash
#FLUX: --job-name=cowy-earthworm-0927
#FLUX: --urgency=16

export num_dev='`echo $CUDA_VISIBLE_DEVICES | awk 'BEGIN{FS=","};{print NF}'`'
export init='step3_charmm2amber'
export pstep='step4.0_minimization'
export istep='step4.1_equilibration'

ml purge  > /dev/null 2>&1 
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4 
ml Amber/18.17-AmberTools-19.12-Python-2.7.16 
nvidia-smi
export num_dev=`echo $CUDA_VISIBLE_DEVICES | awk 'BEGIN{FS=","};{print NF}'`
export init="step3_charmm2amber"
export pstep="step4.0_minimization"
export istep="step4.1_equilibration"
mpirun -np 2 pmemd.cuda.MPI -O -i ${istep}.mdin -p ${init}.parm7 -c ${pstep}.rst7 -o ${istep}1.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -ref ${init}.rst7 -x ${istep}.nc
mpirun -np $num_dev pmemd.cuda.MPI -O -i ${istep}.mdin -p ${init}.parm7 -c ${pstep}.rst7 -o ${istep}2.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -ref ${init}.rst7 -x ${istep}.nc 
mpirun -np 6 pmemd.cuda.MPI -O -i ${istep}.mdin -p ${init}.parm7 -c ${pstep}.rst7 -o ${istep}3.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -ref ${init}.rst7 -x ${istep}.nc 
