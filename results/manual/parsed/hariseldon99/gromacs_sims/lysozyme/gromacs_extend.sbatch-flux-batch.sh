#!/bin/bash
#FLUX: --job-name=lysozyme-extend
#FLUX: -n=24
#FLUX: --queue=GPU
#FLUX: -t=655200
#FLUX: --urgency=16

export SIFPATH='$SIFDIR/gromacs'
export SIFIMG='gromacs-2022.3_20230206.sif'
export MDNAME='md_0_1'
export CPTFILE='${MDNAME}.cpt'
export OMP_NUM_THREADS='$num_proc'
export MPI_NUM_PROCS='1'
export RUNTIME='$( echo "$end - $start" | bc -l )'

start=`date +%s.%N`
echo starting
echo '---------------------------------------------'
num_proc=${SLURM_NTASKS}
echo 'num_proc='$num_proc
echo '---------------------------------------------'
export SIFPATH=$SIFDIR/gromacs
export SIFIMG=gromacs-2022.3_20230206.sif
export MDNAME=md_0_1
export CPTFILE=${MDNAME}.cpt
export OMP_NUM_THREADS=$num_proc
export MPI_NUM_PROCS=1
LD_LIBRARY_PATH="" singularity run --nv -B ${PWD}:/host_pwd --pwd /host_pwd $SIFPATH/$SIFIMG gmx mdrun -ntmpi $MPI_NUM_PROCS -nb gpu -pin on -v -ntomp $OMP_NUM_THREADS -deffnm $MDNAME -cpi ${CPTFILE}
end=`date +%s.%N`
echo "OMP_NUM_THREADS= "$OMP_NUM_THREADS", MPI_NUM_PROCS= "$MPI_NUM_PROCS
export RUNTIME=$( echo "$end - $start" | bc -l )
echo '---------------------------------------------'
echo "Runtime: "$RUNTIME" sec"
echo '---------------------------------------------'
