#!/bin/bash
#FLUX: --job-name=PROC_20-300-40
#FLUX: -n=8
#FLUX: -t=300
#FLUX: --urgency=16

export PLT='${1?Error}'
export NCELLSPERLF='${2?Error}'
export NPTS='100000'
export JHI='`echo "12*${NCELLSPERLF}" | bc -l`'
export NRK='`echo "2*${JHI} + 1" | bc -l`'
export HRK='0.25'
export GROW='`echo "3*${NCELLSPERLF} + 2" | bc -l`'
export i_H2='90'
export PROG_H2='`echo "0.01*${i_H2}" | bc -l`'

set -x
export PLT=${1?Error}
export NCELLSPERLF=${2?Error}
export NPTS=100000
export JHI=`echo "12*${NCELLSPERLF}" | bc -l`
export NRK=`echo "2*${JHI} + 1" | bc -l`
export HRK="0.25"
export GROW=`echo "3*${NCELLSPERLF} + 2" | bc -l`
srun grad3d.gnu.MPI.ex inputs.process infile= ${PLT} #for thermal thickness
srun combinePlts3d.gnu.MPI.ex inputs.process infileL=${PLT} infileR= ${PLT}_gt compsL= 26 compsR= 4 outfile=${PLT}_comb_gt
srun plotProg3d.gnu.MPI.ex inputs.process infile= ${PLT}
srun combinePlts3d.gnu.MPI.ex inputs.process infileL= ${PLT} infileR= ${PLT}_prog compsL= 0 1 2 compsR= 0 1 outfile= ${PLT}_prog_strain
srun curvature3d.gnu.ex inputs.curvature progressName= prog_H2 infile= ${PLT}_prog_strain outfile= ${PLT}_K_H2 #for curvature
srun combinePlts3d.gnu.MPI.ex inputs.process infileL= ${PLT}_K_H2 infileR= ${PLT}_comb_gt compsL= 0 6 11 compsR= 0 1 outfile= ${PLT}_comb_H2
export i_H2=90
export PROG_H2=`echo "0.01*${i_H2}" | bc -l`
srun isosurface3d.gnu.MPI.ex inputs.process \
			comps= 0 \
			isoCompName= prog_H2 isoVal= ${PROG_H2} \
			infile=${PLT}_comb_H2 outfile= ${PLT}_prog_H2_${i_H2}.mef
srun stream3d.gnu.MPI.ex inputs.process \
		progressName= prog_H2 \
		plotfile=${PLT}_comb_H2 \
		isoFile=${PLT}_prog_H2_${i_H2}.mef \
		streamFile=${PLT}_stream_H2_${i_H2} \
		hRK=${HRK} nRKsteps=${NRK}
srun sampleStreamlines3d.gnu.ex inputs.process \
			   nCompsPerPass=1 nGrow=${GROW} \
			   plotfile=${PLT}_comb_H2 \
			   pathFile=${PLT}_stream_H2_${i_H2} \
			   streamSampleFile=${PLT}_stream_sample_H2_${i_H2} \
			   comps= 1 2 3 4
srun streamTubeStats3d.gnu.ex infile= ${PLT}_stream_sample_H2_${i_H2} \
			 intComps= 6 peakComp= 6 7 avgComps= 4 5
srun surfMEFtoDATbasic3d.gnu.MPI.ex infile= ${PLT}_stream_sample_H2_${i_H2}_volInt.mef
