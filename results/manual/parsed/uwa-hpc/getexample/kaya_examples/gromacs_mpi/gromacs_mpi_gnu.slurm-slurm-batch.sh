#!/bin/bash
#FLUX: --job-name=gromacs_mpi
#FLUX: -n=36
#FLUX: --queue=admin
#FLUX: -t=2400
#FLUX: --urgency=16

module load gcc/9.4.0
module load gromacs/2020.4
module list
echo submission dir $SLURM_SUBMIT_DIR
EXECUTABLE=gmx 
SCRATCH=$MYSCRATCH/run_gromacs/$SLURM_JOBID
RESULTS=$MYGROUP/gromacs_results
INPUT_DATA_DIR=${SLURM_SUBMIT_DIR}/gromacs_mpi
GROMACS_DATA_DIR=${SLURM_SUBMIT_DIR}
OUTFILE=1AKI_processed.gro
PDB_FILE=1AKI.pdb
if [ ! -d $SCRATCH ]; then 
    mkdir -p $SCRATCH 
fi 
echo SCRATCH is $SCRATCH
if [ ! -d $RESULTS ]; then 
    mkdir -p $RESULTS 
fi
echo the results directory is $RESULTS
OUTPUT=gromacs_mpi.log
cp $GROMACS_DATA_DIR/*.pdb $SCRATCH
cp $INPUT_DATA_DIR/posre.itp $SCRATCH
cp $INPUT_DATA_DIR/1AKI_processed.gro $SCRATCH
cp $INPUT_DATA_DIR/topol.top $SCRATCH
cp $INPUT_DATA_DIR/*.mdp $SCRATCH
echo gmxlib is $GMXLIB
cd $SCRATCH
gmx pdb2gmx -f ${PDB_FILE} -o $OUTFILE -water spce << EOF
15
0
EOF
gmx editconf -f 1AKI_processed.gro  -o 1AKI_newbox.gro -c -d 1.0 -bt cubic  > ${OUTPUT}
gmx solvate -cp 1AKI_newbox.gro -cs spc216.gro -o 1AKI_solv.gro -p topol.top >> ${OUTPUT}
if [[ ! -f ions.mdp ]]; then 
    wget http://www.mdtutorials.com/gmx/lysozyme/Files/ions.mdp
fi
gmx grompp -f ions.mdp -c 1AKI_solv.gro -p topol.top -o ions.tpr >> ${OUTPUT}
gmx genion -s ions.tpr -o 1AKI_solv_ions.gro -p topol.top  -pname NA -nname CL -nn 8 << EOF 
13
EOF
if [[ ! -f minim.mdp ]]; then
    wget http://www.mdtutorials.com/gmx/lysozyme/Files/minim.mdp
fi 
gmx grompp -f minim.mdp -c 1AKI_solv_ions.gro -p topol.top -o em.tpr >> ${OUTPUT}
gmx mdrun  -v -deffnm em -g energy.log >> ${OUTPUT}
gmx energy -f em.edr -o potential.xvg << EOF
10
0
EOF
if [[ ! -f nvt.mdp ]]
    wget http://www.mdtutorials.com/gmx/lysozyme/Files/nvt.mdp
fi
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -deffnm nvt
gmx energy -f nvt.edr -o temperature.xvg
if [[ ! -f npt.mdp ]]; then
  wget http://www.mdtutorials.com/gmx/lysozyme/Files/npt.mdp 
fi
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -deffnm npt
gmx energy -f npt.edr -o pressure.xvg  << EOF
18
0
EOF
gmx energy -f npt.edr -o density.xvg  << EOF
24
0
EOF
if [[ ! -f md.mdp ]]; then
  wget http://www.mdtutorials.com/gmx/lysozyme/Files/md.mdp
fi
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
gmx mdrun -deffnm md_0_1
gmx trjconv -s md_0_1.tpr -f md_0_1.xtc -o md_0_1_noPBC.xtc -pbc mol -center << EOF
1
0
EOF
gmx rms -s md_0_1.tpr -f md_0_1_noPBC.xtc -o rmsd.xvg -tu ns << EOF
4
EOF
gmx rms -s em.tpr -f md_0_1_noPBC.xtc -o rmsd_xtal.xvg -tu ns  << EOF
4
EOF
gmx gyrate -s md_0_1.tpr -f md_0_1_noPBC.xtc -o gyrate.xvg  << EOF
1
EOF
mv $OUTPUT ${RESULTS}
cd $HOME
echo gromacs_mpi job finished at  `date`
