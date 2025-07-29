#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SvenRogge/supporting-info/2016_ChemMater_v28_p5721_LossOfCrystallinityUiO/NPT_yaff_lammps/scripts/job_yaff_restart.sh
