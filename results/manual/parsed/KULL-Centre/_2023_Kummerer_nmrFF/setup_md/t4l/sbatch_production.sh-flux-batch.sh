#!/bin/bash
#FLUX: --job-name=t4l_cghg
#FLUX: --queue=qgpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo "========= Job started  at `date` =========="
source /comm/specialstacks/gromacs-volta/bin/modules.sh
module load gromacs-gcc-8.2.0-openmpi-4.0.1-cuda-10.1/2020 
cd $SLURM_SUBMIT_DIR/5-md/sim${SLURM_ARRAY_TASK_ID}
gmx_mpi mdrun -deffnm md -nb gpu -pme auto -dlb no -npme 0 -cpi -maxh 23.9 -ntomp 18
gmx_mpi trjconv -f md.xtc -s md.tpr -o md${SLURM_ARRAY_TASK_ID}_prot_nopbc.xtc -pbc mol -ur compact -center <<-EOF
Protein
Protein
EOF
gmx_mpi trjconv -f md${SLURM_ARRAY_TASK_ID}_prot_nopbc.xtc -s md.tpr -o md${SLURM_ARRAY_TASK_ID}_rot_trans.xtc -fit rot+trans <<-EOF
Backbone
Protein
EOF
gmx_mpi rms -f md${SLURM_ARRAY_TASK_ID}_prot_nopbc.xtc -s md.tpr -o rmsd.xvg -xvg none <<-EOF
Protein
Protein
EOF
echo "========= Job finished at `date` =========="
