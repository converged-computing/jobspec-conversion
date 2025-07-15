#!/bin/bash
#FLUX: --job-name=5Drop
#FLUX: -N=12
#FLUX: -n=1152
#FLUX: -t=43200
#FLUX: --priority=16

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
STRUCTURE=./npt_1000.gro
STYLE=npt
LABEL=
MDP_FILE=npt_noConstraints.mdp \
TOPFILE=./topol.top
TPRFILE=$STYLE.tpr
DIR="$STYLE"_"$LABEL"
if [ -f $TPRFILE ]; then
    rm $TPRFILE
fi
if [ ! -f "$STRUCTURE" ]; then
    echo "Error: the structure file does not exist!"
    exit 1
fi
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
               -c $STRUCTURE \
               -r $STRUCTURE \
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
                         -dlb yes \
                         -pin on
fi
