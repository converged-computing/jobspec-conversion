#!/bin/bash
#FLUX: --job-name=evasive-nunchucks-9948
#FLUX: --priority=16

set -e 
NODES=($(srun hostname))
NPROC=$(echo ${NODES[@]} | tr ' ' '\n' | sort | wc -l)
NUNIQ=$(echo ${NODES[@]} | tr ' ' '\n' | sort | uniq | wc -l)
if [[ $NPROC != $NUNIQ ]]
then
        echo "
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Error:
There are more than one process per host.
In your SLURM script file, use:
   #SBATCH --nodes=$NPROC
   #SBATCH --ntasks-per-node=1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        "
        exit -1
fi
PROG=$1
INPUT=$2
if [[ -z ${QP_ROOT} ]]
then
        echo "Error: quantum_package.rc is not sourced"
        exit -1
fi
MASTER_NODE=${NODES[0]}
SLAVE_NODES=$(echo ${NODES[@]:1}| tr ' ' ',')
if [[ $NPROC -gt 1 ]]
then
    echo "Master : $MASTER_NODE"
    echo "Slaves : $SLAVE_NODES"
fi
source ${QP_ROOT}/external/ezfio/Bash/ezfio.sh
ezfio set_file $INPUT
RW=$(ezfio get mo_two_e_ints io_mo_two_e_integrals)
if [[ $RW != Read ]]
then
  echo "
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Warning:
Two-electron integrals were not saved to disk in a previous run.
If the 4-index transformation takes time, you may consider 
killing this job and running 
    qp_run four_idx_transform $INPUT
as a single-node job before re-submitting the current job.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
fi
rm --force -- "${INPUT}"/work/qp_run_address
set -x
srun -N 1 -n 1 qp_run $PROG $INPUT &
if [[ $NPROC -gt 1 ]]
then
    while [[ ! -f $INPUT/work/qp_run_address ]]
    do
        sleep 1
    done
    echo "Starting slaves"
    srun -n $((${SLURM_NTASKS}-1)) qp_run -slave $PROG $INPUT > $INPUT.slaves.out
fi
wait
