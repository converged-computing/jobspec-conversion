#!/bin/bash
#FLUX: --job-name=mom6-solo
#FLUX: -t=3600
#FLUX: --urgency=16

export KMP_STACKSIZE='512m'
export NC_BLKSZ='1M'
export F_UFMTENDIAN='big'

ulimit -s unlimited
mpiexec_prog="/apps/slurm/current/bin/srun --mpi=pmi2"
mpiexec_nopt=-n
mpiexec_topt=-c
workDir=/home/nzadeh/platforms/mom6/exps/mom6_sis2/OM4_1.0deg
machine=googcp
platform=intel19
target=prod
executable=/home/nzadeh/platforms/mom6/builds/build/${machine}-${platform}/ocean_ice/${target}/MOM6SIS2
source /home/nzadeh/platforms/mom6/builds/${machine}/${platform}.env
total_npes=36
omp_threads=1
export KMP_STACKSIZE=512m
export NC_BLKSZ=1M
export F_UFMTENDIAN=big
initialDir=$(pwd)
if ! hash tar 2> /dev/null
then
  echo "ERROR: Unable to find \`tar\` in PATH." 1>&2
  echo "ERROR: Halting script." 1>&2
fi
if ! hash ${mpiexec_prog} 2> /dev/null
then
  echo "ERROR: Unable to find \`${mpiexec_prog}\` in PATH." 1>&2
  echo "ERROR: Halting script." 1>&2
fi
if [ ! -e ${workDir} ]
then
  mkdir -p ${workDir}
  if [ $? -ne 0 ]
  then
    echo "ERROR: Unable to create work directory \"${workDir}\"." 1>&2
    echo "ERROR: Halting script." 1>&2
    exit 1
  fi
elif [ ! -d ${workDir} ]
then
  echo "ERROR: Work directory \"${workDir}\" is not a directory." 1>&2
  echo "ERROR: Halting script." 1>&2
  exit 1
fi
if [ $(ls -1qA ${workDir} | wc -l) -gt 0 ]
then
  echo "NOTE: Work directory \"${workDir}\" is not empty." 1>&2
  echo "NOTE: Data in \"${workDir}\" will be overwritten." 1>&2
fi
cd ${workDir}
if [ $? -ne 0 ]
then
  echo "ERROR: Unable \`cd\` into work directory \"${workDir}\"." 1>&2
  echo "ERROR: Halting script." 1>&2
  exit 1
fi
if [ ! -e RESTART ]
then
  mkdir RESTART
  if [ $? -ne 0 ]
  then
    echo "ERROR: Unable to create directory \"${workDir}/RESTART\"." 1>&2
    echo "ERROR: Halting script." 1>&2
    exit 1
  fi
elif [ ! -d RESTART ]
then
  echo "ERROR: Directory \"${workDir}/RESTART\" is not a directory." 1>&2
  echo "ERROR: Halting script." 1>&2
  exit 1
elif [ $(ls -1qA ${workDir}/RESTART | wc -l) -gt 0 ]
then
  echo "WARNING: Directory \"${workDir}/RESTART\" is not empty." 1>&2
  echo "WARNING: Contents will be overwritten." 1>&2
fi
if [ ! -e INPUT ]
then
  mkdir INPUT
  if [ $? -ne 0 ]
  then
    echo "ERROR: Unable to create directory \"${workDir}/RESTART\"." 1>&2
    echo "ERROR: Halting script." 1>&2
    exit 1
  fi
elif [ ! -d INPUT ]
then
  echo "ERROR: Directory \"${workDir}/INPUT\" is not a directory." 1>&2
  echo "ERROR: Halting script." 1>&2
  exit 1
elif [ $(ls -1qA ${workDir}/INPUT | wc -l) -gt 0 ]
then
  echo "NOTE: Directory \"${workDir}/INPUT\" is not empty." 1>&2
  echo "NOTE: Contents will be used." 1>&2
fi
echo ${mpiexec_prog} ${mpiexec_nopt} ${total_npes} ${mpiexec_topt} ${omp_threads} ${executable}
${mpiexec_prog} ${mpiexec_nopt} ${total_npes} ${mpiexec_topt} ${omp_threads} ${executable} 2>&1 | tee ${workDir}/fms.out
if [ $? -ne 0 ]
then
  echo "ERROR: Run failed." 1>&2
  echo "ERROR: Output from run in \"${workDir}/fms.out\"." 1>&2
  exit 1
fi
mv  fms.out  stdout.${machine}-${platform}.${target}.n${total_npes}
mv ocean.stats ocean.stats.${machine}-${platform}.${target}.n${total_npes}
