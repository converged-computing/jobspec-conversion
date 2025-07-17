#!/bin/bash
#FLUX: --job-name=joyous-citrus-9699
#FLUX: --queue=t4_dev_q
#FLUX: -t=300
#FLUX: --urgency=16

module reset
module load GROMACS/2020.4-fosscuda-2020b
echo "GROMACS_INFER: Normal beginning of execution."
if [ -e gromacs_infer.txt ]; then
  rm gromacs_infer.txt
fi
gmx pdb2gmx -f 1aki.pdb -o 1aki_processed.gro -water spce < pdb2gmx_input.txt &> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx editconf -f 1aki_processed.gro -o 1aki_newbox.gro -c -d 1.0 -bt cubic &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx solvate -cp 1aki_newbox.gro -cs spc216.gro -o 1aki_solv.gro -p topol.top &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx grompp -maxwarn 10 -f ions.mdp -c 1aki_solv.gro -p topol.top -o ions.tpr &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx genion -s ions.tpr -o 1aki_solv_ions.gro -p topol.top -pname NA -nname CL -nn 8 < genion_input.txt &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx grompp -f minim.mdp -c 1aki_solv_ions.gro -p topol.top -o em.tpr &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx mdrun -v -deffnm em &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx energy -f em.edr -o potential.xvg < energy_input1.txt &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx mdrun -deffnm nvt &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
gmx energy -f nvt.edr -o temperature.xvg < energy_input2.txt &>> gromacs_infer.txt
if [ $? -ne 0 ]; then
  echo "GROMACS_INFER: Run error!"
  exit 1
fi
echo ""
echo "GROMACS_INFER: Terminate this short demo at this point."
echo "GROMACS_INFER: Normal end of execution."
exit 0
