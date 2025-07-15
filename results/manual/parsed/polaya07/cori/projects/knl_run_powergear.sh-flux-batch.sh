#!/bin/bash
#FLUX: --job-name=hairy-lemur-2852
#FLUX: --urgency=16

BOOST_VER=1.65.1
FFTW_VER=3.3.6.3
module swap PrgEnv-intel PrgEnv-gnu
module load cray-fftw/$FFTW_VER
module load boost/$BOOST_VER
CURDIR=$HOME/projects/gearshifft
FEXSMALL=$CURDIR/share/gearshifft/extents_small.conf
FEXLARGE=$CURDIR/share/gearshifft/extents_1d_fftw_large.conf
FEXCOMPLETE=$CURDIR/share/gearshifft/extents_1d_fftw_copy.conf
FEXPRUEBA=$CURDIR/share/gearshifft/extents_1d_fftw.conf
FEXTENTS1D=$CURDIR/share/gearshifft/extents_1d_publication.conf
FEXTENTS1DFFTW=$CURDIR/share/gearshifft/extents_1d_fftw.conf  # excluded a few very big ones
FEXTENTS2D=$CURDIR/share/gearshifft/extents_2d_publication.conf
FEXTENTS3D=$CURDIR/share/gearshifft/extents_3d_publication.conf
FEXTENTS=$CURDIR/share/gearshifft/extents_all_publication.conf
today=$(date +%Y_%m_%d-%H:%M:%S)
mkdir $SLURM_JOBID
cd $SLURM_JOBID
echo $(date +%Y_%m_%d-%H:%M:%S)
$HOME/projects/powercap/powercap_plot &
sleep 0.5
echo $(date +%Y_%m_%d-%H:%M:%S)
time $HOME/projects/gearshifft-intel-knl/bin/gearshifft_fftwwrappers -f $FEXSMALL -v -o "$HOME/projects/results/$today-knl_wc.csv" --rigor estimate
sleep 0.5
pkill -KILL -u polaya $HOME/projects/powercap/powercap_plot
echo $(date +%Y_%m_%d-%H:%M:%S)
kill %1
