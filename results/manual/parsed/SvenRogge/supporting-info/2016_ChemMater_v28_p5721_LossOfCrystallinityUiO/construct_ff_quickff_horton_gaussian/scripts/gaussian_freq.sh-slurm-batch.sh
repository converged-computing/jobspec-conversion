#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SvenRogge/supporting-info/2016_ChemMater_v28_p5721_LossOfCrystallinityUiO/construct_ff_quickff_horton_gaussian/scripts/gaussian_freq.sh
