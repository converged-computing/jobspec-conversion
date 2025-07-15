#!/bin/bash
#FLUX: --job-name=boopy-cat-7123
#FLUX: --urgency=16

export KMP_AFFINITY='disabled'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export XDG_CONFIG_HOME='/dev/shm'
export rowstart='500'
export name_for_run='cosmos_new_seed  '
export dataset='cosmos'
export nobj='50'
export threads='16'
export cosmos_section='$1  '
export rsdir='rs${rowstart}_cosmos${cosmos_section}'
export PYTHONPATH='./mpi:$PYTHONPATH'
export topdir='$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/'
export outdir='$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}'

export KMP_AFFINITY=disabled
export MPICH_GNI_FORK_MODE=FULLCOPY
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export XDG_CONFIG_HOME=/dev/shm
srun -n $SLURM_JOB_NUM_NODES mkdir -p $XDG_CONFIG_HOME/astropy
export rowstart=0
export name_for_run=cosmos_new_seed  
export dataset=cosmos
export nobj=50
export threads=16
export cosmos_section=$1  
export rsdir=cosmos${cosmos_section}
export PYTHONPATH=./mpi:$PYTHONPATH
export topdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/
export rowstart=100
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=150
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=200
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=250
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=300
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=350
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=400
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=450
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
export rowstart=500
export rsdir=rs${rowstart}_cosmos${cosmos_section}
export outdir=$CSCRATCH/Obiwan/dr9_LRG/obiwan_out/$name_for_run/output/${rsdir}
mkdir -p $outdir
srun -N 5 -n 20 -c 16 shifter --module=mpich-cle6 --image=legacysurvey/legacypipe:DR9.7.1 python mpi.py
