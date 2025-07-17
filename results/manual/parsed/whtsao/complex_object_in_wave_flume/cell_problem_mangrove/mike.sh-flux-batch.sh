#!/bin/bash
#FLUX: --job-name=cell
#FLUX: -n=64
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/packages/compilers/intel/compiler/2022.0.2/linux/compiler/lib/intel64_lin:${LD_LIBRARY_PATH}'
export MV2_HOMOGENEOUS_CLUSTER='1'

date
module load proteus/fct
export LD_LIBRARY_PATH=/home/packages/compilers/intel/compiler/2022.0.2/linux/compiler/lib/intel64_lin:${LD_LIBRARY_PATH}
export MV2_HOMOGENEOUS_CLUSTER=1
mkdir -p $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cd $SLURM_SUBMIT_DIR
cp setup.py $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cp cell.py $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp mangrove.pyx $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp mangrove_2.pyx $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp nse_p.py $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp nse_n.py $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp petsc.options.asm $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp *.sh $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cd $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
python setup.py build_ext -i
srun parun nse_p.py nse_n.py -F -l 5 -C "he=.0125 usePETSc=True cell_bottom=0.50 cell_height=0.05 T=100.0" -O petsc.options.asm -D p50
exit 0
