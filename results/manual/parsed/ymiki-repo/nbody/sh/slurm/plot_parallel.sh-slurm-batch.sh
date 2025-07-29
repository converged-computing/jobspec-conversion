#!/bin/bash
#FLUX: --job-name=visualize
#FLUX: -n=8
#FLUX: --queue=regular
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load anyenv
module load miniforge3
module load julia
module load texlive
module load openmpi
if [ -z "$EXEC" ]; then
    EXEC="julia jl/plot/dot.jl"
fi
if [ -n "$SLURM_NTASKS_PER_NODE" ]; then
	CONFIG_NODE="--wrapper-Nprocs_node=$SLURM_NTASKS_PER_NODE"
fi
if [ -n "$SLURM_NTASKS_PER_SOCKET" ]; then
	CONFIG_SOCKET="--wrapper-Nprocs_socket=$SLURM_NTASKS_PER_SOCKET"
fi
MPL_CFG_DIR=/tmp/matplotlib
echo $LOADEDMODULES | grep -e openmpi -e intelmpi -e mvapich
if [ $? -eq 0 ]; then
	echo "mpiexec -n $SLURM_NTASKS sh/wrapper/mpi_matplotlib.sh $CONFIG_NODE $CONFIG_SOCKET --wrapper-mpl_cfg_dir=$MPL_CFG_DIR $EXEC --png $OPTION"
	mpiexec -n $SLURM_NTASKS sh/wrapper/mpi_matplotlib.sh $CONFIG_NODE $CONFIG_SOCKET --wrapper-mpl_cfg_dir=$MPL_CFG_DIR $EXEC --png $OPTION
else
	if [ `which numactl` ]; then
		echo "numactl --localalloc $EXEC --png $OPTION"
		numactl --localalloc $EXEC --png $OPTION
	else
		echo "$EXEC --png $OPTION"
		$EXEC --png $OPTION
	fi
fi
exit 0
