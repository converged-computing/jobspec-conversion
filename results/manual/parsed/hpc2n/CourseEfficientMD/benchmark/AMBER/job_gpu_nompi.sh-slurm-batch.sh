#!/bin/bash
#SBATCH --account=SNICyyyy-xx-yy
#SBATCH --output=job_str.out
#SBATCH --error=job_str.err
#SBATCH --nodes=1
#SBATCH --ntasks=14
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --time=00:25:00

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
