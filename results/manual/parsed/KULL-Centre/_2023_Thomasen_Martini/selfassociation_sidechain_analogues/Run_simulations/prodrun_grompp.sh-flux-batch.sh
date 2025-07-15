#!/bin/bash
#FLUX: --job-name=md_grompp
#FLUX: --queue=qgpu
#FLUX: -t=3600
#FLUX: --urgency=16

echo "========= Job started  at `date` =========="
cd $SLURM_SUBMIT_DIR
source /comm/specialstacks/gromacs-volta/bin/modules.sh
module load gromacs-gcc-8.2.0-openmpi-4.0.3-cuda-10.1
gmx_mpi make_ndx -f relax.tpr -o tmp_prodrun.ndx <<EOF
ri 1
ri 2
q
EOF
gmx_mpi grompp -f ../../md.mdp -p all_PRO.top -c relax.gro -t relax.cpt -o prodrun.tpr -n tmp_prodrun.ndx -v
rm tmp_prodrun.ndx
echo "========= Job finished at `date` =========="
