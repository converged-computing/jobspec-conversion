#!/bin/bash
#SBATCH --job-name=NAME2_analysis
#SBATCH --account=pi-depablo
#SBATCH --output=LOG/NAME2_analysis.ou
#SBATCH --error=LOG/NAME2_analysis.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=06:00:00
#SBATCH --qos=depablo-tc-sn
#SBATCH --constraint=ntasks-per-node=1

CONF="/project2/depablo/achabbi/scripts/conformation.py"
module load gromacs/2022.4+oneapi-2021
module load python/anaconda-2021.05
gmx_mpi energy -f npt/npt.edr -o npt/density.xvg -b 5000 <<< density | grep "Density" | tail -1 | awk '{print $2, $3}' >> numbers.txt
gmx_mpi msd -f nvt/nvt.xtc -s nvt/nvt.tpr -o nvt/msd.xvg -sel 0 -beginfit 30000 -endfit 70000
grep 'D\[    System\]' nvt/msd.xvg | sed 's/)//g' | awk '{print $7, $9}' >> numbers.txt
gmx_mpi polystat -f nvt/nvt.xtc -s nvt/nvt.tpr -o nvt/conformation.xvg <<< 0
python ${CONF} nvt/conformation.xvg numbers.txt
