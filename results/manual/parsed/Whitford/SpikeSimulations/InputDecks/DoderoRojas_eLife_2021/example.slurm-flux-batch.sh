#!/bin/bash
#FLUX: --job-name=sim-wg-tmb
#FLUX: -n=4
#FLUX: -c=7
#FLUX: --exclusive
#FLUX: --queue=short
#FLUX: -t=86100
#FLUX: --urgency=16

module load gcc/6.4.0  openmpi/3.1.2  cmake/3.10.0
CUTOFF=8
echo "$SLURM_ARRAY_TASK_ID"
GMX_EXE={PATH_TO_GROMACS}/bin/gmx_mpi
FILES_DIR='./'
[ ! -d "height_95" ] && mkdir height_95
cd height_95
height="95.000";
sed 's/HOST_MEMBRANE/'${height}'/g' ${FILES_DIR}/moveable_host_membrane.gro > rr_95.gro
mkdir rr_${SLURM_ARRAY_TASK_ID}
cd rr_${SLURM_ARRAY_TASK_ID}
cp ${FILES_DIR}/res.itp ./
srun -n 1 $GMX_EXE grompp -f ${FILES_DIR}/steep.mdp -p ${FILES_DIR}/postfusion_with_glycans_pre_TM.top -c ${FILES_DIR}/prefusion_with_glycans_bb.gro -o run.tpr -maxwarn 1 -r ${FILES_DIR}/height_95/rr_95.gro -n ${FILES_DIR}/index.ndx
srun $GMX_EXE mdrun -s run.tpr -v -maxh 24 -ntomp 8
mv confout.gro prefusion_with_glycans_bb_${SLURM_ARRAY_TASK_ID}.gro
rm run.tpr traj_comp.xtc traj.trr 
srun -n 1 $GMX_EXE grompp -f ${FILES_DIR}/base.mdp -p ${FILES_DIR}/postfusion_with_glycans_pre_TM.top -c prefusion_with_glycans_bb_${SLURM_ARRAY_TASK_ID}.gro -o run.tpr -maxwarn 1 -r ${FILES_DIR}/height_95/rr_95.gro -n ${FILES_DIR}/index.ndx
srun $GMX_EXE mdrun -s run.tpr -v -maxh 1 -ntomp 7 -dd 1 1 1 -nsteps -1
mv traj_comp.xtc traj_${SLURM_ARRAY_TASK_ID}.xtc 
mv traj.trr traj_${SLURM_ARRAY_TASK_ID}.trr 
srun -n 1 $GMX_EXE distance -f traj_${SLURM_ARRAY_TASK_ID}.xtc -n ${FILES_DIR}/index.ndx -oxyz -select 'cog of group "TM" plus cog of group "HG"'
awk '{print $1, ($3*$3 + $2*$2)^(1/2), $4}' distxyz.xvg > distrz.xvg
rd=`tail -q -n1 distrz.xvg | awk '{print $2}'`
m=`echo $rd'>'$CUTOFF | bc -l`
echo $rd $m $CUTOFF > status_run_${SLURM_ARRAY_TASK_ID}.dat
if [ "$m" -ne "1" ]
then
	jb1=$(sbatch ${FILES_DIR}/resub.slurm -height 95 -rep_id ${SLURM_ARRAY_TASK_ID} -fd ${FILES_DIR} | awk '{print $4}'); 
	echo $jb1 > jobs.txt
	mv traj_${SLURM_ARRAY_TASK_ID}.xtc traj_comp.xtc 
	mv traj_${SLURM_ARRAY_TASK_ID}.trr traj.trr 
fi
