#!/bin/bash
#FLUX: --job-name=sample_job
#FLUX: --exclusive
#FLUX: --queue=b1164
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load python-anaconda3
source activate /projects/b1164/software/clingo-py38
. /projects/b1164/src//spack/share/spack/setup-env.sh
spack load gcc@10.3.0
spack load /lmfyckl
spack install lammps@20210310%intel+asphere+body+class2+colloid+compress~coreshell+cuda~cuda_mps+dipole+exceptions+ffmpeg+granular~ipo+jpeg+kim~kokkos+kspace+latte+lib+manybody+mc~meam+misc~mliap+molecule+mpi+mpiio~opencl+openmp~opt+peri+png+poems+python+qeq+replica+rigid+shock+snap+spin+srd~user-adios~user-atc~user-awpmd~user-bocs~user-cgsdk+user-colvars~user-diffraction~user-dpd~user-drude~user-eff+user-fep~user-h5md~user-lb~user-manifold~user-meamc~user-mesodpd~user-mesont~user-mgpt+user-misc~user-mofff~user-netcdf~user-omp~user-phonon~user-plumed~user-ptm~user-qtb~user-reaction+user-reaxc~user-sdpd~user-smd~user-smtbq~user-sph~user-tally~user-uef~user-yaff+voronoi build_type=RelWithDebInfo cuda_arch=86 arch=linux-rhel7-x86_64 ^ffmpeg@4.2.2 ^/4o4ifwv ^/lmfyckl
