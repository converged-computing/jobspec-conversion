#!/bin/bash
#FLUX: --job-name=grated-kerfuffle-8831
#FLUX: --exclusive
#FLUX: --priority=16

export PATH='/glade/work/ssuresh/1810pgi/linux86-64/18.10/mpi/openmpi-2.1.2/bin/:$PATH'
export LD_LIBRARY_PATH='/glade/work/ssuresh/1810pgi/linux86-64/18.10/mpi/openmpi-2.1.2/lib/:$LD_LIBRARY_PATH'
export PNETCDF='/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/'
export NETCDF='/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/'
export PIO='/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/'
export MPAS_EXTERNAL_LIBS='-L/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/lib/ -lhdf5_hl -lhdf5 -ldl -lz'
export MPAS_EXTERNAL_INCLUDES='-I/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/include'
export PGI_ACC_TIME='1'
export OMPI_MCA_btl_openib_if_include='mlx5_0'

module purge
export PATH=/glade/work/ssuresh/1810pgi/linux86-64/18.10/bin/:$PATH
export LD_LIBRARY_PATH=/glade/work/ssuresh/1810pgi/linux86-64/18.10/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/glade/work/ssuresh/1810pgi/linux86-64/18.10/mpi/openmpi-2.1.2/lib/:$LD_LIBRARY_PATH
export PATH=/glade/work/ssuresh/1810pgi/linux86-64/18.10/mpi/openmpi-2.1.2/bin/:$PATH
which mpif90
export PNETCDF=/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/
export NETCDF=/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/
export PIO=/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/
export MPAS_EXTERNAL_LIBS="-L/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/lib/ -lhdf5_hl -lhdf5 -ldl -lz"
export MPAS_EXTERNAL_INCLUDES="-I/glade/work/ssuresh/1810pgi/pgi1810_lib/libs-pgi1810/include"
ulimit -s unlimited
module list
env
sinfo
echo $LD_LIBRARY_PATH
cd /glade/scratch/slaksh/mcworkshop/benchmark
echo $LDFLAGS
export PGI_ACC_TIME=1
export OMPI_MCA_btl_openib_if_include=mlx5_0
srun --mem=0 --mpi=pmix ./atmosphere_model
