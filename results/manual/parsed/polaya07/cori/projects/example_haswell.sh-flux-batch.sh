#!/bin/bash
#FLUX: --job-name=gearshifft
#FLUX: -n=64
#FLUX: --queue=regular
#FLUX: -t=600
#FLUX: --urgency=16

BOOST_VER=1.67.0
FFTW_VER=3.3.6.5
module swap PrgEnv-intel PrgEnv-gnu
module load cray-fftw/$FFTW_VER
module load boost/$BOOST_VER
CURDIR=$HOME/projects/gearshifft
FEXUNIQUE=$CURDIR/share/gearshifft/extents_uni.conf
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
size=8192
echo $SLURM_JOBID	
mkdir $SLURM_JOBID
cd $SLURM_JOBID 
mkdir $size
cd $size
echo $(date +%Y_%m_%d-%H:%M:%S)
$HOME/projects/powercap/powercap_plot &
sleep 0.5
echo $(date +%Y_%m_%d-%H:%M:%S)
time $HOME/projects/gearshifft-gnu-wc/bin/gearshifft_fftw -e $size -r */double/*/*_Real -v -o "$HOME/projects/$SLURM_JOBID/$size/haswell_wc.csv" --rigor estimate
sleep 0.5
pkill -KILL -u polaya $HOME/projects/powercap/powercap_plot
echo $(date +%Y_%m_%d-%H:%M:%S)
kill %1
