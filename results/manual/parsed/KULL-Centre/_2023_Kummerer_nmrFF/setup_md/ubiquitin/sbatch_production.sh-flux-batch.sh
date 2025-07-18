#!/bin/bash
#FLUX: --job-name=ubi_opt
#FLUX: --queue=qgpu
#FLUX: -t=234000
#FLUX: --urgency=16

echo "========= Job started  at `date` =========="
echo This job is running on the following node\(s\):
echo $SLURM_NODELIST
source /comm/specialstacks/gromacs-volta/bin/modules.sh
module load gromacs-tmpi-plumed2-2.7.3-gcc-8.2.0-openmpi-4.0.3-cuda-10.1/2021.4
mkdir 5-md/sim${SLURM_ARRAY_TASK_ID}
cd $SLURM_SUBMIT_DIR/4-npt/
cp -r amber99sb-star-ildn.ff *.itp npt.gro topol.top npt.cpt ../5-md/sim${SLURM_ARRAY_TASK_ID}
cd $SLURM_SUBMIT_DIR/5-md/sim${SLURM_ARRAY_TASK_ID}
gmx grompp -f /home/kummerer/UBI_FERRAGE/a99sb-star-ildn/md/mdp_files/md_npt.mdp -c npt.gro -r npt.gro -t npt.cpt -p topol.top -o md.tpr -maxwarn 2
gmx mdrun -deffnm md -nb gpu -pme auto -dlb no -npme 0 -cpi -maxh 64.9 -ntomp 18
gmx trjconv -f md.xtc -s md.tpr -o md${SLURM_ARRAY_TASK_ID}_prot_nopbc.xtc -pbc mol -ur compact -center <<-EOF
Protein
Protein
EOF
gmx trjconv -f md${SLURM_ARRAY_TASK_ID}_prot_nopbc.xtc -s md.tpr -o md${SLURM_ARRAY_TASK_ID}_rot_trans.xtc -fit rot+trans <<-EOF
Backbone
Protein
EOF
gmx rms -f md${SLURM_ARRAY_TASK_ID}_prot_nopbc.xtc -s md.tpr -o rmsd.xvg -xvg none <<-EOF
Protein
Protein
EOF
echo "========= Job finished at `date` =========="
