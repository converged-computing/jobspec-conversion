#!/bin/bash
#FLUX: --job-name=gromacs-run
#FLUX: -n=36
#FLUX: --queue=queue0
#FLUX: --priority=16

export SPACK_ROOT='/shared/spack'

export SPACK_ROOT=/shared/spack
mkdir -p $SPACK_ROOT
cd $SPACK_ROOT/..
git clone -c feature.manyFiles=true https://github.com/spack/spack 
echo "export SPACK_ROOT=$SPACK_ROOT" >> $HOME/.bashrc
echo "source \$SPACK_ROOT/share/spack/setup-env.sh" >> $HOME/.bashrc
source $HOME/.bashrc
spack mirror add binary_mirror https://binaries.spack.io/develop
spack buildcache keys --install --trust
spack compiler find
cat << EOF > $SPACK_ROOT/etc/spack/packages.yaml
packages:
    intel-mpi:
        externals:
        - spec: intel-mpi@2020.4.0
          prefix: /opt/intel/mpi/2021.4.0/
        buildable: False
    libfabric:
        variants: fabrics=efa,tcp,udp,sockets,verbs,shm,mrail,rxd,rxm
        externals:
        - spec: libfabric@1.13.2 fabrics=efa,tcp,udp,sockets,verbs,shm,mrail,rxd,rxm
          prefix: /opt/amazon/efa
        buildable: False
    openmpi:
        variants: fabrics=ofi +legacylaunchers schedulers=slurm ^libfabric
        externals:
        - spec: openmpi@4.1.1 %gcc@7.3.1
          prefix: /opt/amazon/openmpi
    pmix:
        externals:
          - spec: pmix@3.2.3 ~pmi_backwards_compatibility
            prefix: /opt/pmix
    slurm:
        variants: +pmix sysconfdir=/opt/slurm/etc
        externals:
        - spec: slurm@21.08.8-2 +pmix sysconfdir=/opt/slurm/etc
          prefix: /opt/slurm
        buildable: False
EOF
spack config --scope site add "modules:default:tcl:all:autoload: direct"
spack config --scope site add "modules:default:tcl:verbose: True"
spack config --scope site add "modules:default:tcl:hash_length: 6"
spack config --scope site add "modules:default:tcl:projections:all: '{name}/{version}-{compiler.name}-{compiler.version}'"
spack config --scope site add "modules:default:tcl:all:conflict: ['{name}']"
spack config --scope site add "modules:default:tcl:all:suffixes:^cuda: cuda"
spack config --scope site add "modules:default:tcl:all:environment:set:{name}_ROOT: '{prefix}'"
spack config --scope site add "modules:default:tcl:openmpi:environment:set:SLURM_MPI_TYPE: 'pmix'"
spack config --scope site add "modules:default:tcl:openmpi:environment:set:OMPI_MCA_btl_tcp_if_exclude: 'lo,docker0,virbr0'"
spack config --scope site add "modules:default:tcl:intel-oneapi-mpi:environment:set:SLURM_MPI_TYPE: 'pmi2'"
spack config --scope site add "modules:default:tcl:mpich:environment:set:SLURM_MPI_TYPE: 'pmi2'"
spack install gromacs
sudo yum install -y bsdtar
mkdir -p /shared/input/gromacs
wget -qO- https://www.mpinat.mpg.de/benchRIB | bsdtar xf - -C /shared/input/gromacs
wget -qO- https://www.mpinat.mpg.de/benchMEM | bsdtar xf - -C /shared/input/gromacs
cat << EOF > /shared/input/gromacs/submit.sh
spack load gromacs
mkdir -p /shared/jobs/101
cd /shared/jobs/101
mpirun -n 18 gmx_mpi mdrun -ntomp 2 -s /shared/input/gromacs/benchRIB.tpr -resethway
EOF
cd $HOME
wget https://www.ks.uiuc.edu/Research/vmd/vmd-1.9.3/files/final/vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz
tar xf vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz
cd vmd-1.9.3/
./configure
cd src/
sudo make install
