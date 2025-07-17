#!/bin/bash
#FLUX: --job-name=bench2
#FLUX: -N=2
#FLUX: --queue=main
#FLUX: -t=900
#FLUX: --urgency=16

ml PDC/21.09 
ml all-spack-modules/0.16.3
ml CMake/3.21.2
mkdir build
cd build
cmake ~/Private/gromacs-constantph -DGMX_MPI=ON -DGMX_USE_RDTSCP=ON -DCMAKE_INSTALL_PREFIX=${PWD}/.. -DGMX_BUILD_OWN_FFTW=ON
make -j 12
make install -j 12
cd ..
rm -r build
source ${PWD}/bin/GMXRC
srun gmx_mpi grompp -f MD.mdp -c CA.pdb -p topol.top -n index.ndx -o MD.tpr
srun gmx_mpi mdrun -deffnm MD -npme 0 -g GLIC_2n_64_4_DLBNO.log -resetstep 20000 -ntomp 4 -dlb yes -pin on -pinstride 2
