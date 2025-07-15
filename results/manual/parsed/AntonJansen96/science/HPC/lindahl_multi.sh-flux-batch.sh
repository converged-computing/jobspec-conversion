#!/bin/bash
#FLUX: --job-name=NAME
#FLUX: --queue=lindahl
#FLUX: -t=172799
#FLUX: --urgency=16

module load cmake/latest
module load gcc/7.4
module load cuda/10.2
mkdir build
cd build
CC=gcc-7 CXX=g++-7 cmake ~/gromacs-constantph -DGMX_USE_RDTSCP=ON -DCMAKE_INSTALL_PREFIX=${PWD}/.. -DGMX_BUILD_OWN_FFTW=ON -DGMX_GPU=CUDA
make -j 12
make install -j 12
cd ..
rm -r build
source ${PWD}/bin/GMXRC
cpus=$(( $SLURM_JOB_CPUS_PER_NODE / 4 ))
{
    export CUDA_VISIBLE_DEVICES=0
    cd 01
    if [ ! -e MD.tpr ]
    then
        gmx grompp -f MD.mdp -c CA.pdb -p topol.top -n index.ndx -o MD.tpr -maxwarn 1
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 0 ))
    else
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -cpi MD.cpt -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 0 ))
    fi
} &
{
    export CUDA_VISIBLE_DEVICES=1
    cd 02
    if [ ! -e MD.tpr ]
    then
        gmx grompp -f MD.mdp -c CA.pdb -p topol.top -n index.ndx -o MD.tpr -maxwarn 1
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 1 ))
    else
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -cpi MD.cpt -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 1 ))
    fi
} &
{
    export CUDA_VISIBLE_DEVICES=2
    cd 03
    if [ ! -e MD.tpr ]
    then
        gmx grompp -f MD.mdp -c CA.pdb -p topol.top -n index.ndx -o MD.tpr -maxwarn 1
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 2 ))
    else
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -cpi MD.cpt -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 2 ))
    fi
} &
{
    export CUDA_VISIBLE_DEVICES=3
    cd 04
    if [ ! -e MD.tpr ]
    then
        gmx grompp -f MD.mdp -c CA.pdb -p topol.top -n index.ndx -o MD.tpr -maxwarn 1
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 3 ))
    else
        gmx mdrun -deffnm MD -c MD.pdb -x MD.xtc -cpi MD.cpt -npme 0 -maxh 47 -bonded gpu -nt $cpus -pin on -pinstride 1 -pinoffset $(( $cpus * 3 ))
    fi
} &
wait
sbatch job_multi.sh
