#!/bin/bash
#SBATCH --job-name=33_100cm_U_0.25_Q_100E6
#SBATCH --output=run-%j.out
#SBATCH --error=run-%j.err
#SBATCH --mail-user=cristian.garrido@idom.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1

set -eu
spack load openfoam@2306
source ~/.venvs/pyfoam/bin/activate
./Allrun-parallel
pyFoamPlotWatcher.py --with-all --implementation='matplotlib' --hardcopy --solver-not-running-anymore --progress log.chtMultiRegionSimpleFoam
pyFoamClearCase.py --no-allclean-script --keep-last --keep-postprocessing --processors-remove --vtk-keep .
