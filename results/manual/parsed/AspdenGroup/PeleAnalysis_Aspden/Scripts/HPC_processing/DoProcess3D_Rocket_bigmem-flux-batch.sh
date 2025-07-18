#!/bin/bash
#FLUX: --job-name=jobName
#FLUX: -n=64
#FLUX: --queue=bigmem
#FLUX: -t=900
#FLUX: --urgency=16

export NCELLSPERLF='16'
export NPTS='100000'
export JHI='`echo "12*${NCELLSPERLF}" | bc -l`'
export NRK='`echo "2*${JHI} + 1" | bc -l`'
export HRK='0.25'
export GROW='`echo "3*${NCELLSPERLF} + 2" | bc -l`'
export i_H2='90'
export PROG_H2='`echo "0.01*${i_H2}" | bc -l`'

set -x
for PLT in `cat pltlist`; do
export NCELLSPERLF=16
export NPTS=100000
export JHI=`echo "12*${NCELLSPERLF}" | bc -l`
export NRK=`echo "2*${JHI} + 1" | bc -l`
export HRK="0.25"
export GROW=`echo "3*${NCELLSPERLF} + 2" | bc -l`
srun grad3d.gnu.MPI.ex inputs.process infile= ${PLT} #for thermal thickness
srun combinePlts3d.gnu.MPI.ex inputs.process infileL=${PLT} infileR= ${PLT}_gt compsL= 26 compsR= 4 outfile=${PLT}_comb_gt
rm -r ${PLT}_gt #up to you
srun plotProg3d.gnu.MPI.ex inputs.process infile= ${PLT}
srun combinePlts3d.gnu.MPI.ex inputs.process infileL= ${PLT} infileR= ${PLT}_prog compsL= 0 1 2 compsR= 0 1 outfile= ${PLT}_prog_strain
rm -r ${PLT}_prog #up to you
srun curvature3d.gnu.MPI.ex inputs.curvature progressName= prog_H2 infile= ${PLT}_prog_strain outfile= ${PLT}_K_H2 #for curvature
srun combinePlts3d.gnu.MPI.ex inputs.process infileL= ${PLT}_K_H2 infileR= ${PLT}_comb_gt compsL= 0 6 11 compsR= 0 1 outfile= ${PLT}_comb_H2
rm -r ${PLT}_comb_gt ${PLT}_K_H2 ${PLT}_prog_strain #up to you
export i_H2=90
export PROG_H2=`echo "0.01*${i_H2}" | bc -l`
srun isosurface3d.gnu.MPI.ex inputs.process \
			comps= 0 \
			isoCompName= prog_H2 isoVal= ${PROG_H2} \
			infile=${PLT}_comb_H2 outfile= ${PLT}_prog_H2_${i_H2}.mef
./qslim3d.gnu.ex -t ${NPTS} ${PLT}_prog_H2_${i_H2}.mef > ${PLT}_prog_H2_${i_H2}_${NPTS}.mef
srun stream3d.gnu.MPI.ex inputs.process \
		progressName= prog_H2 \
		plotfile=${PLT}_comb_H2 \
		isoFile=${PLT}_prog_H2_${i_H2}_${NPTS}.mef \
		streamFile=${PLT}_stream_H2_${i_H2}_${NPTS} \
		hRK=${HRK} nRKsteps=${NRK}
srun sampleStreamlines3d.gnu.MPI.ex inputs.process \
			   nCompsPerPass=1 nGrow=${GROW} \
			   plotfile=${PLT}_comb_H2 \
			   pathFile=${PLT}_stream_H2_${i_H2}_${NPTS} \
			   streamSampleFile=${PLT}_stream_sample_H2_${i_H2}_${NPTS} \
			   comps= 1 2 3 4
./streamTubeStats3d.gnu.ex infile= ${PLT}_stream_sample_H2_${i_H2}_${NPTS} \
			 intComps= 6 peakComp= 6 7 avgComps= 4 5
srun surfMEFtoDATbasic3d.gnu.MPI.ex infile= ${PLT}_stream_sample_H2_${i_H2}_${NPTS}_volInt.mef
srun surfMEFtoDAT3d.gnu.MPI.ex infile= ${PLT}_stream_sample_H2_${i_H2}_${NPTS}_volInt.mef
done
