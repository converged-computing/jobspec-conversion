#!/bin/bash
#FLUX: --job-name=aro
#FLUX: --exclusive
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_STACKSIZE='4G'
export KMP_STACKSIZE='4G'
export KMP_MONITOR_STACKSIZE='1G'
export DR_HOOK='1'
export DR_HOOK_IGNORE_SIGNALS='-1'
export DR_HOOK_OPT='prof'
export EC_PROFILE_HEAP='0'
export EC_MPI_ATEXIT='0'
export PATH='$HOME/bin:$HOME/benchmf1709/scripts:$PATH'
export workdir='/scratch/work/marguina'
export TMPDIR='$workdir/tmp/aro.$SLURM_JOBID'
export GRIB_DEFINITION_PATH='$PWD/extra_grib_defs:$grib_api_prefix/share/definitions:$grib_api_prefix/share/eccodes/definitions'
export GRIB_SAMPLES_PATH='$grib_api_prefix/ifs_samples/grib1:$grib_api_prefix/share/eccodes/ifs_samples/grib1'

set -x
ulimit -s unlimited
export OMP_STACKSIZE=4G
export KMP_STACKSIZE=4G
export KMP_MONITOR_STACKSIZE=1G
export DR_HOOK=1
export DR_HOOK_IGNORE_SIGNALS=-1
export DR_HOOK_OPT=prof
export EC_PROFILE_HEAP=0
export EC_MPI_ATEXIT=0
export PATH=$HOME/bin:$HOME/benchmf1709/scripts:$PATH
DATA=/scratch/work/marguina/benchmf1709-data
export workdir=/scratch/work/marguina
export TMPDIR=$workdir/tmp/aro.$SLURM_JOBID
mkdir -p $TMPDIR
cd $TMPDIR
for NAM1 in LTWOTL=T.ARO LTWOTL=F.ARO HAIL
do
for NAM2 in NHEE NHQE
do
mkdir -p $NAM1.$NAM2
cd $NAM1.$NAM2
 GRID=0064x0064
 PACK=/home/gmap/mrpm/marguina/pack/cy48t1_cpg_drv.01.MIMPIIFC1805.2y.pack
for f in $DATA/aro/grid/$GRID/* $DATA/aro/code/43oops/data/* 
do
  if [ -f "$f" ]
  then
    \rm -f $(basename $f)
    ln $f .
  fi
done
for f in $PACK/data/*
do
  b=$(basename $f)
  \rm -f $b
  ln -s $f $b
done
cp EXSEG1.nam EXSEG1.nam.tmp
\rm -f EXSEG1.nam
mv EXSEG1.nam.tmp EXSEG1.nam
chmod 644 EXSEG1.nam
for f in $DATA/aro/code/43oops/naml/*
do
  cp $f .
  chmod 644 $(basename $f)
done
NNODE_FC=1
NTASK_FC=4
NOPMP_FC=8
NNODE_IO=0
NTASK_IO=32
NOPMP_IO=4
let "NPROC_FC=$NNODE_FC*$NTASK_FC"
let "NPROC_IO=$NNODE_IO*$NTASK_IO"
STOP=1
xpnam --delta="
&NAMRIP
  CSTOP='h$STOP',
  TSTEP=60,
/
&NAMARG
  CUSTOP=-,
  UTSTEP=-,
/
&NAMCVER
  NVSCH=-,
  NVFE_TYPE=1,
/
&NAMTRAJ
/
&NAMCT0
  LNHDYN=-,
  LNHEE=.TRUE.,
  LGRIB_API=.FALSE.,
/
&NAETLDIAG
/
&NAMDVISI
/
&NAMSATSIM
/
&NAMPHY0
  GREDDRS=-,
/
&NAMNORGWD
/
&NAMMETHOX
/
&NAMNUDGLH
/
&NAMSPP
/
&NAMFA
  NVGRIB=0,
/
" --inplace fort.4
xpnam --delta="
&NAMIO_SERV
  NPROC_IO=$NPROC_IO,
/
&NAMPAR0
  NPROC=$NPROC_FC,
  $(square $NPROC_FC)
/
&NAMPAR1
  NSTRIN=$NPROC_FC,
/
" --inplace fort.4
xpnam --delta="
&NAM_ISBAn
  CROUGH=-,
/
" --inplace EXSEG1.nam
xpnam --delta="
$(cat $PACK/nam/$NAM1.nam)
" --inplace fort.4
xpnam --delta="
$(cat $PACK/nam/$NAM2.nam)
" --inplace fort.4
perl -e '
for (1 .. 100)
  {
    my $i = $_-1;
    print "  NSDITS($_)=$i,\n"
  }' > nsdist.nam
perl -i -ne ' print unless (m/\bNSDITS\b/o) ' fort.4
xpnam --delta="
&NAMCT0
   NSDITS(0)=100,
$(cat nsdist.nam)
/
" --inplace fort.4
perl -i -ne ' print unless (m/CROUGH/o) ' EXSEG1.nam
grib_api_prefix=$(ldd $PACK/bin/MASTERODB  | perl -ne ' 
   next unless (m/libeccodes_f90/o); 
   my ($path) = (m/=>\s+(\S+)/o); 
   use File::Basename; 
   print &dirname (&dirname ($path)), "\n" ')
export GRIB_DEFINITION_PATH=$PWD/extra_grib_defs:$grib_api_prefix/share/definitions:$grib_api_prefix/share/eccodes/definitions
export GRIB_SAMPLES_PATH=$grib_api_prefix/ifs_samples/grib1:$grib_api_prefix/share/eccodes/ifs_samples/grib1
if [ 1 -eq 1 ]
then
xpnam --delta="
&NAMDIM
  NPROMA=-4,
/
" --inplace fort.4
fi
ls -lrt
cat fort.4
pack=$PACK
/opt/softs/mpiauto/mpiauto --verbose --wrap --wrap-stdeo --nouse-slurm-mpi --prefix-mpirun '/usr/bin/time -f "time=%e"' \
    --nnp $NTASK_FC --nn $NNODE_FC --openmp $NOPMP_FC -- $pack/bin/MASTERODB \
 -- --nnp $NTASK_IO --nn $NNODE_IO --openmp $NOPMP_IO -- $pack/bin/MASTERODB 
ls -lrt
diffNODE.001_01 NODE.001_01 $PACK/ref/NODE.001_01.$NAM1.$NAM2
cd ..
done
done
