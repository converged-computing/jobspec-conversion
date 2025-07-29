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
#SBATCH --mem=50G
#SBATCH --time=2-00:00:00
#SBATCH --qos=normal

echo "### Starting at: $(date) ###"
source /storage/hpc/hpc-poc/micore/gromacs-gputhread/bin/GMXRC
module load cuda/cuda-8.0
module load hwloc/hwloc-1.11.4
module list
gmx_gputhread mdrun -s step5_production.tpr -cpi md.cpt -append -deffnm md #make sure the -deffnm is the SAME as whatever it was in the original mdrun call
echo "### Ending at: $(date) ###"
