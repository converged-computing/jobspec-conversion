#!/bin/bash
#FLUX: --job-name=NVT_equilibration
#FLUX: -n=64
#FLUX: -c=2
#FLUX: --queue=cops
#FLUX: -t=172800
#FLUX: --priority=16

export GMX_ENABLE_DIRECT_GPU_COMM='1'
export OMP_NUM_THREADS='$ntomp'

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -o)
            WORK_DIR=$2
            shift
            shift
            ;;
        -f)
            MDP=$2
            shift
            shift
            ;;
        -p)
            TOPOL=$2
            shift
            shift
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift # past argument
            ;;
    esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters
echo "OUTPUT PATH     = ${WORK_DIR}"
echo "MDP FILE        = ${MDP}"
echo "BOX             = ${BOX}"
echo "TOPOLOGY FILE   = ${TOPOL}"
echo -e "Submitting job...\n"
export GMX_ENABLE_DIRECT_GPU_COMM=1
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    ntomp="$SLURM_CPUS_PER_TASK"
else
    ntomp="1"
fi
if [ -n "$CHECKPOINT" ]; then
    cpi="-cpi $WORK_DIR/nvt"
    tpr="$WORK_DIR/nvt_next.tpr"
else
    cpi=""
    tpr="$WORK_DIR/nvt.tpr"
    gmx grompp -f $MDP -c $WORK_DIR/em.gro -r $WORK_DIR/em.gro -p $TOPOL -o $tpr
fi
export OMP_NUM_THREADS=$ntomp
if [[ "${SLURM_NNODES}" -gt "1" ]]; then
    export MPIRUN="$HOME/openmpi-4.1.5/build/bin/mpirun --mca opal_warn_on_missing_libcuda 0"
    $MPIRUN -np $SLURM_NTASKS gmx_mpi mdrun -v -pin on -ntomp $ntomp -deffnm $WORK_DIR/nvt -npme -1
else
    gmx mdrun -v -pin on -ntmpi $SLURM_NTASKS -ntomp $ntomp -deffnm $WORK_DIR/nvt -npme -1
fi
