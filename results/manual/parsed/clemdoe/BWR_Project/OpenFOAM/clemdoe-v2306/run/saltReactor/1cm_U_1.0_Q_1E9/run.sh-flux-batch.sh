#!/bin/bash
#FLUX: --job-name=expressive-signal-5086
#FLUX: -n=40
#FLUX: --urgency=16

set -eu
spack load openfoam@2306
source ~/.venvs/pyfoam/bin/activate
./Allrun-parallel
pyFoamPlotWatcher.py --with-all --implementation='matplotlib' --hardcopy --solver-not-running-anymore --progress log.chtMultiRegionSimpleFoam
pyFoamClearCase.py --no-allclean-script --keep-last --keep-postprocessing --processors-remove --vtk-keep .
