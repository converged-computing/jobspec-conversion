#!/bin/bash
#FLUX: --job-name=EQUIL
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpuA100x8
#FLUX: --urgency=16

export PLUMED_NUM_THREADS='16'
export OMP_NUM_THREADS='12'
export TF_INTRA_OP_PARALLELISM_THREADS='2'
export TF_INTER_OP_PARALLELISM_THREADS='2'
export SLURM_CPU_BIND='cores'
export cycles='100'

cd $SLURM_SUBMIT_DIR
source ~/env/lmp_deepmd.sh
export PLUMED_NUM_THREADS=16
export OMP_NUM_THREADS=12
export TF_INTRA_OP_PARALLELISM_THREADS=2
export TF_INTER_OP_PARALLELISM_THREADS=2
export SLURM_CPU_BIND="cores"
export cycles=100
if [ -e restart.lmp.0 ] ; then
    if [ -s restart.lmp.0 ]; then
	echo restart.lmp.0 exists
    else
	echo restart.lmp.0 does not exists, copying restart2.lmp.0
	cp  restart2.lmp.0 restart.lmp.0
    fi
    nn=`tail -n 1 runno | awk '{print $1}'`
    srun $LAMMPS_EXE -in Restart.lmp
else
    nn=1
    srun $LAMMPS_EXE  -in start.lmp
fi
