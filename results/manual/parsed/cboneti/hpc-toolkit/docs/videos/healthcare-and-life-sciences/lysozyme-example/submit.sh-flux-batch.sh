#!/bin/bash
#FLUX: --job-name=stanky-parrot-8469
#FLUX: --queue=gpu
#FLUX: --priority=16

PDB_FILE=1AKI.pdb
PROTEIN="${PDB_FILE%.*}"
echo "$PDB_FILE"
echo "$PROTEIN"
source /apps/spack/share/spack/setup-env.sh
spack env activate gromacs
which gmx_mpi
grep -v -e HETATM -e CONECT "${PDB_FILE}" >"${PROTEIN}"_protein.pdb
mpirun -n 1 gmx_mpi pdb2gmx -f "${PROTEIN}"_protein.pdb -o "${PROTEIN}"_processed.gro -water tip3p -ff "charmm27"
mpirun -n 1 gmx_mpi editconf -f "${PROTEIN}"_processed.gro -o "${PROTEIN}"_newbox.gro -c -d 1.0 -bt dodecahedron
mpirun -n 1 gmx_mpi solvate -cp "${PROTEIN}"_newbox.gro -cs spc216.gro -o "${PROTEIN}"_solv.gro -p topol.top
mpirun -n 1 gmx_mpi grompp -f config/ions.mdp -c "${PROTEIN}"_solv.gro -p topol.top -o ions.tpr
printf "SOL\n" | mpirun -n 1 gmx_mpi genion -s ions.tpr -o "${PROTEIN}"_solv_ions.gro -p topol.top -pname NA -nname CL -neutral
MDRUN_GPU_PARAMS=(-gputasks 00 -bonded gpu -nb gpu -pme gpu -update gpu)
MDRUN_MPIRUN_PREAMBLE=(mpirun -n 1 -H localhost env GMX_ENABLE_DIRECT_GPU_COMM=1)
mpirun -n 1 gmx_mpi grompp -f config/emin-charmm.mdp -c "${PROTEIN}"_solv_ions.gro -p topol.top -o em.tpr
"${MDRUN_MPIRUN_PREAMBLE[@]}" gmx_mpi mdrun -v -deffnm em
mpirun -n 1 gmx_mpi grompp -f config/nvt-charmm.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
"${MDRUN_MPIRUN_PREAMBLE[@]}" gmx_mpi mdrun -v -deffnm nvt "${MDRUN_GPU_PARAMS[@]}"
mpirun -n 1 gmx_mpi grompp -f config/npt-charmm.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
"${MDRUN_MPIRUN_PREAMBLE[@]}" gmx_mpi mdrun -v -deffnm npt "${MDRUN_GPU_PARAMS[@]}"
mpirun -n 1 gmx_mpi grompp -f config/md-charmm.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
"${MDRUN_MPIRUN_PREAMBLE[@]}" gmx_mpi mdrun -v -deffnm md "${MDRUN_GPU_PARAMS[@]}"
printf "1\n" | mpirun -n 1 gmx_mpi trjconv -s md.tpr -f md.xtc -o md_protein.xtc -pbc mol
printf "1\n1\n" | mpirun -n 1 gmx_mpi trjconv -s md.tpr -f md_protein.xtc -fit rot+trans -o md_fit.xtc
cp "${PROTEIN}"_newbox.gro /data_output/
cp md_fit.xtc /data_output/"${PROTEIN}"_md.xtc
