#!/bin/bash
#FLUX: --job-name=qphix_block_benchmark
#FLUX: -N=125
#FLUX: -c=48
#FLUX: --exclusive
#FLUX: --queue=skl_usr_prod
#FLUX: -t=43200
#FLUX: --priority=16

export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT='disable'
export HFI_NO_CPUAFFINITY='1'
export I_MPI_HYDRA_ENV='all'
export I_MPI_FABRICS='shm:tmi'
export I_MPI_PIN='1'
export I_MPI_DEBUG='4'
export I_MPI_PIN_DOMAIN='3'
export OMP_NUM_THREADS='3'
export KMP_AFFINITY='balanced,granularity=fine'

module purge
module load env-skl/1.0
module load intel/pe-xe-2018--binary intelmpi/2018--binary mkl/2018--binary
RUNDIR=/marconi_work/INF18_lqcd123/bartek/tests/qphix_80c160_blocks
ODIR=${RUNDIR}/outputs
if [ ! -d ${ODIR} ]; then
  mkdir -p ${ODIR}
  mkdir ${ODIR}
fi
cd ${RUNDIR}
export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=disable
export HFI_NO_CPUAFFINITY=1
export I_MPI_HYDRA_ENV=all
export I_MPI_FABRICS=shm:tmi
export I_MPI_PIN=1
export I_MPI_DEBUG=4
export I_MPI_PIN_DOMAIN=3
export OMP_NUM_THREADS=3
export KMP_AFFINITY="balanced,granularity=fine"
ofile=qphix_scan.dat
arch_arr=( "avx2" "skylake" )
by_arr=( 1 2 4 8 )
bz_arr=( 1 2 4 8 )
padxy_arr=( 0 1 )
padxyz_arr=( 0 1 )
njobs=$(( ${#arch_arr[@]} *
          ${#by_arr[@]} *
          ${#bz_arr[@]} *
          ${#padxy_arr[@]} *
          ${#padxyz_arr[@]} ))
njob=0
datfile=qphix_scan.dat
echo "arch by bz padxy padxyz tts" > ${datfile}
for arch in "avx2" "skylake" "skl_soalen4"; do
  EXE=/marconi_work/INF18_lqcd123/bartek/build/${arch}/tmLQCD_cC211_06_80_production/invert
  if [ "${arch}" = "skl_soalen4" ]; then
    EXE=/marconi_work/INF18_lqcd123/bartek/build/skylake/tmLQCD_cC211_06_80_production_soalen4/invert
  fi
  for by in 1 2 4 8; do
    for bz in 1 2 4 8; do
      for padxy in 0 1; do
        for padxyz in 0 1; do
          njob=$(( ${njob} + 1 ))
          idstring=arch-${arch}_by${by}_bz${bz}_padxy${padxy}_padxyz${padxyz}
          ifile=${idstring}.input
          cp input.template ${ifile}
          sed -i "s/_BY_/${by}/g" ${ifile}
          sed -i "s/_BZ_/${bz}/g" ${ifile}
          sed -i "s/_PADXY_/${padxy}/g" ${ifile}
          sed -i "s/_PADXYZ_/${padxyz}/g" ${ifile}
          ofile=outputs/${idstring}.out
          echo "Job ${njob} out of ${njobs}" | tee -a ${ofile}
          echo "arch=${arch} by=${by} bz=${bz} padxy=${padxy} padxyz=${padxyz}" | tee -a ${ofile}
          tts_arr=( $( mpirun -n $(( 125 * 16 )) -ppn 16 $EXE -f ${ifile} 2>&1 | \
            tee -a ${ofile} | grep "Inversion done" | grep sec | awk '{print $4}') )
          for tts in ${tts_arr[@]}; do
            echo ${arch} ${by} ${bz} ${padxy} ${padxyz} ${tts} | tee -a ${datfile}
          done
        done # padxyz
      done # padxy
    done # bz
  done # by
done # arch
