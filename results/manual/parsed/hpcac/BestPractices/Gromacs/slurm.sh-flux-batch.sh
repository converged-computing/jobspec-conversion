#!/bin/bash
#FLUX: --job-name=gromacs
#FLUX: -N=2
#FLUX: --queue=thor
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load md/gromacs/2018-hpcx-2.1.0-intel-2018.1.163
MPI_FLAGS="--display-map --report-bindings --map-by core --bind-to core"
UCX_FLAGS="-mca pml ucx -x UCX_NET_DEVICES=mlx5_0:1"
HCOLL_FLAGS="-mca coll_fca_enable 0 -mca coll_hcoll_enable 1 -x HCOLL_MAIN_IB=mlx5_0:1"
EXE=gmx_mpi
cd $SLURM_SUBMIT_DIR
mkdir gromacs
cd gromacs
wget -c ftp://ftp.gromacs.org/pub/benchmarks/gmxbench-3.0.tar.gz
tar zxpvf gmxbench-3.0.tar.gz
cd d.dppc
sed -i.bak 's/#include "spc.itp"/#include "amber99sb-ildn.ff\/tip3p.itp"/' topol.top
sed -i.bak 's/rcoulomb                 = 1.8/rcoulomb                 = 1.0/' grompp.mdp
${EXE} grompp -f grompp.mdp -c conf.gro -p topol.top -o mdrun.tpr
time mpirun ${MPI_FLAGS} ${UCX_FLAGS} ${HCOLL_FLAGS} ${EXE} mdrun -s mdrun.tpr
