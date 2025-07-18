#!/bin/bash
#FLUX: --job-name=Production_Run
#FLUX: -c=24
#FLUX: --queue=ampere
#FLUX: -t=432000
#FLUX: --urgency=16

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
        -g)
            CHECKPOINT=$2
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
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    ntomp="$SLURM_CPUS_PER_TASK"
else
    ntomp=1
fi
if [ -n "$CHECKPOINT" ]; then
    cpi="-cpi $WORK_DIR/md"
    tpr="$WORK_DIR/md_next.tpr"
else
    cpi=""
    tpr="$WORK_DIR/md.tpr"
    gmx grompp -f $MDP -c $WORK_DIR/nvt.gro -r $WORK_DIR/nvt.gro -p $TOPOL -o $tpr
fi
export OMP_NUM_THREADS=$ntomp
NTMPI="-ntmpi $SLURM_NTASKS"
$HOME/sw/gromacs-thread/2023.1/bin/gmx mdrun \
    -s $tpr -pme gpu -pmefft gpu -nb gpu -bonded gpu -pin on -pinstride 1 \
    -ntmpi $SLURM_NTASKS -ntomp $SLURM_CPUS_PER_TASK -deffnm $WORK_DIR/md $cpi
