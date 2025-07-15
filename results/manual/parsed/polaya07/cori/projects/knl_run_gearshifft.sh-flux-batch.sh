#!/bin/bash
#FLUX: --job-name=conspicuous-omelette-3232
#FLUX: --priority=16

BOOST_VER=1.65.1
FFTW_VER=3.3.6.3
module swap PrgEnv-intel/6.0.4  PrgEnv-gnu
module load cray-fftw/$FFTW_VER
module load boost/$BOOST_VER
CURDIR=$HOME/projects/gearshifft
FEXTENTS1D=$CURDIR/share/gearshifft/extents_1d_publication.conf
FEXPRUEBA=$CURDIR/share/gearshifft/extents_1d_fftw_copy.conf 
FEXTENTS1DFFTW=$CURDIR/share/gearshifft/extents_1d_fftw.conf  # excluded a few very big ones
FEXTENTS2D=$CURDIR/share/gearshifft/extents_2d_publication.conf
FEXTENTS3D=$CURDIR/share/gearshifft/extents_3d_publication.conf
FEXTENTS=$CURDIR/share/gearshifft/extents_all_publication.conf
today=$(date +%Y_%m_%d-%H:%M:%S) 
time $HOME/projects/gearshifft-intel-knl/bin/gearshifft_fftwwrappers -f $FEXTENTS1DFFTW -v -o "$HOME/projects/results/$today-knl_wc.csv" --rigor estimate
