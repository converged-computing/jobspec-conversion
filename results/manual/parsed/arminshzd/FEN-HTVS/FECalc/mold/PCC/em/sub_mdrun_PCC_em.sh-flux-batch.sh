#!/bin/bash
#FLUX: --job-name=hello-parsnip-4418
#FLUX: -c=5
#FLUX: --queue=gm4-pmext
#FLUX: -t=129600
#FLUX: --urgency=16

NCPU=$(($SLURM_NTASKS_PER_NODE))
NTHR=$(($SLURM_CPUS_PER_TASK))
NNOD=$(($SLURM_JOB_NUM_NODES))
NP=$(($NCPU * $NNOD * $NTHR))
module unload openmpi gcc cuda python
module load openmpi/4.1.1+gcc-10.1.0 cuda/11.2
source /project/andrewferguson/armin/grom_new/gromacs-2021.6/installed-files-mw2-256/bin/GMXRC
gmx editconf -f PCC_GMX.gro -o PCC_box.gro -c -d 1.0 -bt cubic
gmx solvate -cp PCC_box.gro -cs spc216.gro -o PCC_sol.gro -p topol.top
CHARGE=$1
echo "System total charge: $CHARGE"
if [ $CHARGE -ne 0 ]
then
    gmx grompp -f ions.mdp -c PCC_sol.gro -p topol.top -o ions.tpr -maxwarn 2
    gmx genion -s ions.tpr -o PCC_sol_ions.gro -p topol.top -pname NA -nname CL -neutral << EOF
4
EOF
    gmx grompp -f em.mdp -c PCC_sol_ions.gro -p topol.top -o em.tpr
else
    gmx grompp -f em.mdp -c PCC_sol.gro -p topol.top -o em.tpr
fi
gmx mdrun -ntomp "$NP" -deffnm em
frames_dir="frames.temp"
ndx_dir="lastframe.ndx"
gmx check -f em.trr 2>&1 | tee $frames_dir > /dev/null
nframes=$(grep "Step" $frames_dir | awk '{print $NF}')
cat << EOF > $ndx_dir
[ last_frame ]
$nframes
EOF
gmx trjconv -s em.tpr -f em.trr -o PCC_em.pdb -pbc whole -conect -fr $ndx_dir <<EOF
2
EOF
