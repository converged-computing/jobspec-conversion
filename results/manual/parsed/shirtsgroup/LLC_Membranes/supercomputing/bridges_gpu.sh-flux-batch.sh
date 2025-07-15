#!/bin/bash
#FLUX: --job-name=nerdy-plant-3234
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/home/bjc/Gromacs"  # Bridges forgets what is written in your .bashrc'

module purge  # clear out modules or else mdtraj gets screwed up
module load gromacs/2018_gpu  # GPU accelerated gromacs installed by Marcela Madrid
module load python/3.6.4_gcc5_np1.14.5  # this is the only version where numpy works. Will need to install mdtraj (pip install --user mdtraj)
export PYTHONPATH="$PYTHONPATH:/home/bjc/Gromacs"  # Bridges forgets what is written in your .bashrc
source /home/bjc/pkgs/gromacs/2018.3/bin/GMXRC # User installed threaded version of Gromacs since running grompp in parallel probably isn't a good idea
