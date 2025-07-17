#!/bin/bash
#FLUX: --job-name=omp_photon
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: --queue=defq
#FLUX: -t=18000
#FLUX: --urgency=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/install/'
export CC='icc'
export CXX='icpc'
export KMP_AFFINITY='verbose,compact'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/install/
module load git intel cmake boost python
export CC=icc
export CXX=icpc
unset KMP_AFFINITY
export KMP_AFFINITY="verbose,compact"
for I in 2 4 8 12 16 20 40 80
do
	export OMP_NUM_THREADS=$I
	cd ../build_omp
	./bench 0 100 12.4 1 1 0 0 ../../../data_pool/px_101016/allpede_250us_1243__B_000000.dat ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/px_101016/Insu_6_tr_1_45d_250us__B_000000.dat cores$I /bigdata/hplsim/production/jungfrau-photoncounter/reference/cluster_energy.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/bin/photon.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/maxValues.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/sum.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/clusters.bin
done
