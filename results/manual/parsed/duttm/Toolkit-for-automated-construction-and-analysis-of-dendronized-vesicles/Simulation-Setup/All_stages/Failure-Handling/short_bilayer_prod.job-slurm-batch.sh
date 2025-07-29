#!/bin/bash
#FLUX: --job-name=G1_Bialyer_Basic
#FLUX: -c=4
#FLUX: --queue=compute
#FLUX: -t=3600
#FLUX: --urgency=16

export OMPI_MCA_btl='self,vader'
export OMP_NUM_THREADS='4'

module purge
module load slurm
module load cpu
module load gcc/10.2.0
module load openmpi
module load gromacs/2019.6
export OMPI_MCA_btl=self,vader
tar xvf package.tar.gz
module purge
module load slurm
module load cpu
module load gcc/10.2.0
module load openmpi
module load gromacs/2019.6
extra_pins="-pin on -resethway"
export OMP_NUM_THREADS=4
start=10
skip=2
i=$((start+skip-2))
echo $i
GRO=$i-input.gro
tpr=$((++i))-input
minim=npt_5fs_short_test.mdp
top=system.top
out=$((++i))-input
restart=12-input_prev.cpt
mpirun -np 1 gmx_mpi grompp -f $minim  -c $GRO -p $top -o $tpr -t $restart
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -v -deffnm $out -s $tpr  $extra_pins
