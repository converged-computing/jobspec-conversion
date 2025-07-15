#!/bin/bash
#FLUX: --job-name=hpl_mpi_test
#FLUX: --exclusive
#FLUX: --queue=cf1
#FLUX: -t=42900
#FLUX: --urgency=16

export PATH='~tin/gsHPCS_toolkit/benchmark/hpl/hpl-2.2/bin/intel64_nehalem:$PATH	# lr4/savio are hashwell, but can't find binary for it...'

echo "mpirun for xHPL run via slurm"
echo ----slurm-resource-allocated-------------------
echo -n "SLURMD_NODENAME: "
echo    $SLURMD_NODENAME
echo -n "SLURM_JOB_NUM_NODES: "		# Total number of nodes in the job's resource allocation.
echo    $SLURM_JOB_NUM_NODES
echo -n "SLURM_JOB_NODELIST: "
echo    $SLURM_JOB_NODELIST
echo -n "SLURM_TASKS_PER_NODE: "	# eg 64(x2)  , so will be some work before using it for CorePerNode 
echo    $SLURM_TASKS_PER_NODE
echo -n "SLURM_NTASKS_PER_NODE: "   	# Number of tasks requested per core. Only set if the --ntasks-per-core option is specified.
echo    $SLURM_NTASKS_PER_NODE
echo -n "SLURM_MEM_PER_NODE: "		# got blank!
echo    $SLURM_MEM_PER_NODE
echo -n "SLURM_CPUS_ON_NODE: "		# 64 for n0000.cf1 knl
echo    $SLURM_CPUS_ON_NODE
echo -n "SLURM_JOB_PARTITION:"
echo    $SLURM_JOB_PARTITION
echo -n "SLURM_JOB_QOS:"
echo    $SLURM_JOB_QOS
echo ""
echo ""
JobBaseDir=/global/scratch/tin/benchmark_hpl/ 
CorePerNode=24	# n0282.savio2: 2x12
NNode=${SLURM_JOB_NUM_NODES}
Ncore=$(( $NNode * $CorePerNode ))
HplDatNum=$( printf %04d $NNode )
FECHA=$(date "+%m%d_%H%M")
RUNDIR=./STAGING_OUT/J${SLURM_JOB_ID}_${SLURM_JOB_PARTITION}_${NNode}x${SLURM_CPUS_ON_NODE}_${FECHA}
test -d $RUNDIR || mkdir $RUNDIR
cd $RUNDIR
cp -p ~/gsCF_BK/cf1/staging_test/hpl_mpi.job .			# path may change... 
BIOSOUT=/tmp/bios.settings.out
BIOSHIGHLIGHT=/tmp/bios.settings.highlight
cp -p $BIOSOUT       .         2> /dev/null
cp -p $BIOSHIGHLIGHT .         2> /dev/null
export PATH=~tin/gsHPCS_toolkit/benchmark/hpl/hpl-2.2/bin/intel64_nehalem:$PATH	# lr4/savio are hashwell, but can't find binary for it...
test -d hpl || mkdir hpl
cp -p  ~/gsHPCS_toolkit/benchmark/hpl/hpl_cf/24cores_64gb_90_nb192/HPL.MPI*dat hpl   # 24 core lr4/savio2
module purge
module load intel openmpi				# lr4/savio2 nehalem hpl
module list
numactl -H > numactl-H.out
ompi_info -a > ompi_info-a.out
echo "----------- which hpl --------------"
which xhpl
which mpirun
echo "----- mpirun hpl hostname and location  -----"
hostname
pwd
date
echo ----MPL.dat to copy is hpl/HPL.MPI.${HplDatNum}.dat HPL.dat
echo ----HPL.dat--is--hpl/HPL.MPI.${HplDatNum}.dat----
cp -p hpl/HPL.MPI.${HplDatNum}.dat HPL.dat
echo "----------- HPL.dat --------------"
cat HPL.dat
echo "----------- mpi run --------------"
echo ""
echo "###"
echo "----------- mpi run 1 - simple, get nodelist --------------"
MpiCmd="mpirun -np ${NNode} -npernode 1 hostname"
echo running cmd: ${MpiCmd}
${MpiCmd} | sort -n
echo ""
echo "###"
echo "----------- mpi run 2 - linpack job --------------"
MpiCmd="mpirun -np ${Ncore} -npernode ${CorePerNode} xhpl"
hostname > HPL.starttime
date 	>> HPL.starttime
echo running cmd: ${MpiCmd}
${MpiCmd} |tee mpi-HPL-2.log
date > HPL.endtime
echo "end of mpirun for hpl via slurm."
