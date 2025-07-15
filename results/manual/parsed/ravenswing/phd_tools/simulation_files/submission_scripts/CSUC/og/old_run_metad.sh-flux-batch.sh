#!/bin/bash
#FLUX: --job-name=butterscotch-snack-5873
#FLUX: --urgency=16

export GMX='gmx_mpi'
export GMX_DISABLE_GPU_TIMING='yes'

steps=50		# Maximum number of steps to run. 
traj=metad		# Name of all output files. 
ndx=i.ndx		# Name of index file.
prev=md			# Name of previous .gro and .cpt files.
module load apps/gromacs/2023_plumed_2.9
export GMX=gmx_mpi
export GMX_DISABLE_GPU_TIMING=yes
log_line() {
	local timestamp="$(date +"%F %T")"
	local line='.............................................'
	echo $(printf "%s  %s%s %s\n" "$timestamp" "$2" "${line:${#2}}" "$1")
}
FN=$(cd ..; basename -- "$PWD")
plumed=plumed_${FN}.dat
tmax=$(($steps*10000))
printf "INFO | SUBMIT_DIR:  %s \n" $SLURM_SUBMIT_DIR > run.log
printf "INFO | NODENAME:  %s \n" $SLURMD_NODENAME >> run.log
printf "INFO | RUNNING ON:  %s \n" $SLURM_SUBMIT_HOST >> run.log
i=1
$GMX grompp -f step10.mdp -c $prev.gro -p $FN.top -o ${traj}${i}.tpr -t $prev.cpt -r $prev.gro -n $ndx
echo $(log_line "RUNNING" "Step $i ") >> run.log
OMP_NUM_THREADS=24 srun -n 1 -c 24 $GMX mdrun -dlb auto -pin auto -s ${traj}${i}.tpr -deffnm ${traj} -plumed $plumed
echo $(log_line "COMPLETED" "Step $i ") >> run.log
cp $traj.cpt ${traj}_step${i}.cpt
for i in $(seq 2 $steps)
do	
    # Extend the previous tpr by 10 ns.
    $GMX convert-tpr -s ${traj}$((i-1)).tpr -o ${traj}${i}.tpr -extend 10000
    echo $(log_line "RUNNING" "Step $i ") >> run.log
    # Run the next step. 
    OMP_NUM_THREADS=24 srun -n 1 -c 24 $GMX mdrun -dlb auto -pin auto -s ${traj}${i}.tpr -deffnm ${traj} -cpi ${traj}_step$((i-1)).cpt -noappend -plumed $plumed
    echo $(log_line "COMPLETED" "Step $i ") >> run.log
    # Backup checkpoint file and update the log file.
    cp $traj.cpt ${traj}_step${i}.cpt 
done
exit
