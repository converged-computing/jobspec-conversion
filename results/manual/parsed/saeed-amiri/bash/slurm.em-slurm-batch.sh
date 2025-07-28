#!/bin/bash
#FLUX: --job-name=15ODA@EM
#FLUX: -N=4
#FLUX: -n=384
#FLUX: -t=43200
#FLUX: --urgency=16

export SLURM_CPU_BIND='none'
export SLURM_CPUS_PER_TASK='$THREADS'
export OMP_NUM_THREADS='$THREADS'
export GMX_MAXCONSTRWARN='-1'

echo $(date)
echo -e "================================================================================\n"
THREADS=2
export SLURM_CPU_BIND=none
export SLURM_CPUS_PER_TASK=$THREADS
export OMP_NUM_THREADS=$THREADS
export GMX_MAXCONSTRWARN=-1
module load intel/19.1.3
module load impi/2019.9
module load gromacs/2021.2-plumed
STRCTURE=./system.gro
STYLE=em
MDP_FILE="$STYLE.mdp"
LABEL=afterUpdate23
TOPFILE=./topol.top
TPRFILE=$STYLE.tpr
if [[ -n "$LABEL" ]]; then
    DIR="$STYLE"_"$LABEL"
else
    DIR="$STYLE"
fi
if [ -f $TPRFILE ]; then
    rm $TPRFILE
fi
if [ ! -f "$STRCTURE" ]; then
    echo "Error: the structure file does not exist!"
    exit 1
fi
existDirs=( */ )
largest_integer=0
for dir_name in "${existDirs[@]}"; do
    if [[ "$dir_name" =~ ^([0-9]+)_ ]]; then
        existing_integer="${BASH_REMATCH[1]}"
        if ((existing_integer > largest_integer)); then
            largest_integer="$existing_integer"
        fi
    fi
    echo -e "Exiting loop for dir: ${dir_name}"
done
((largest_integer++))
DIR="${largest_integer}_${DIR}"
cat << EOF
 *******************
 Directory is $DIR
 *******************
 The topology file contains:
EOF
echo -e "\n*******************\n"
cat $TOPFILE
echo -e "\n*******************\n"
cat "$MDP_FILE"
echo -e "\n*******************\n"
gmx_mpi grompp -f $MDP_FILE \
               -c $STRCTURE \
               -r $STRCTURE \
               -p $TOPFILE \
               -n index.ndx \
               -o $STYLE.tpr \
               -maxwarn -1
if [ -f $TPRFILE ]; then
    srun --cpus-per-task=$SLURM_CPUS_PER_TASK \
        gmx_mpi mdrun -v -s $TPRFILE \
                         -o $STYLE \
                         -e $STYLE \
                         -x $STYLE \
                         -c $STYLE \
                         -cpo $STYLE \
                         -ntomp $THREADS \
                         -pin on
else
    PWD=$(pwd)
    echo "The job in dir: ${PWD} crashed, jobid: ${SLURM_JOB_ID}"
fi
if [ -f $STYLE.gro ]; then
    mkdir $DIR
    mv $STYLE.* $DIR/
    mv md.log $DIR/
    mv mdout.mdp $DIR/
    cp $DIR/$STYLE.mdp .
    echo "My Slurm job ID is: ${SLURM_JOB_ID}" > $DIR/JOBID
fi
cat << EOF
 *******************
 Directory is $DIR
 *******************
EOF
