#!/bin/bash
#SBATCH --account=ec110-guest
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --time=01:00:00
#SBATCH --qos=standard
#SBATCH --exclusive

export MEQTREES_CATTERY_PATH='/work/sc004/shared/software/meqtrees-cattery/1.7.0'

module unload anaconda
module use /work/sc004/shared/software/modules
module load fftw/3.3.8-intel19
module load owlcat
module load kittens
module load pyxis/latest
module load py-casacore
module load tigger
module load meqtrees-cattery
module load meqtrees-timba
export MEQTREES_CATTERY_PATH=/work/sc004/shared/software/meqtrees-cattery/1.7.0
module load astropy
module load mpt
module load wsclean/2.10.1
pyxis MSLOW=CYG-A-5-8M10S.MS MSHIGH=CYG-A-7-8M10S.MS FRISTCH=0 LASTCH=15 FIELDID=2 SRCNAME=CYGA MSTAG=CYGA-ConfigA getdata_ms_concat_bandwidth
pyxis MSLOW=CYG-C-5-8M10S.MS MSHIGH=CYG-C-7-8M10S.MS FRISTCH=0 LASTCH=15 FIELDID=2 SRCNAME=CYGA MSTAG=CYGA-ConfigC getdata_ms_concat_bandwidth
