#!/bin/bash
#SBATCH --job-name=gromacs
#SBATCH --account=general-gpu
#SBATCH --output=results_gromacs-%j.out
#SBATCH --mail-user=------@mail.missouri.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=75G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu3
#SBATCH --qos=normal

echo "### Starting at: $(date) ###"
source /group/micore/gromacs2018.3-gputhread/bin/GMXRC
module load hwloc/hwloc-1.11.9
module load cuda/cuda-9.2.148
module list
gmx_gputhread grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step4.0_minimization.gro -n index.ndx -p topol.top
gmx_gputhread mdrun -s step4.1_equilibration.tpr -v -deffnm step4.1_equilibration
gmx_gputhread grompp -f step5_production.mdp -o step5_production.tpr -c step4.1_equilibration.gro -n index.ndx -p topol.top
gmx_gputhread mdrun -s step5_production.tpr -deffnm md
echo "### Ending at: $(date) ###"
