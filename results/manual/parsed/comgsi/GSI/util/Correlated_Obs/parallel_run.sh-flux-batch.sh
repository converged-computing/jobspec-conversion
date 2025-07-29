#!/bin/bash
#FLUX: --job-name=cov_calc
#FLUX: --urgency=16

bdate=2014040700
edate=2014041718
instr=iasi_metop-a
exp=prCtl
diagdir=/scratch4/NCEPDEV/da/noscrub/${USER}/archive/${exp}
wrkdir=/scratch4/NCEPDEV/stmp4/${USER}/corr_obs
savdir=$diagdir
type=1
cloud=2
angle=30
wave_out=.false.
err_out=.false.
corr_out=.false.
kreq=-150
method=1
cov_method=2
time_sep=1.0
bsize=1
bcen=80
chan_set=0
num_proc=11
NP=16
unpack_walltime=02:30:00
wall_time=01:00:00
Umem=50
Mem=50
account=da-cpu
project_code=GFS-T2O
machine=theia
netcdf=0
ndate=/scratch4/NCEPDEV/da/save/Michael.Lueken/nwprod/util/exec/ndate
cdate=$bdate
[ ! -d ${wrkdir} ] && mkdir ${wrkdir}
nt=0
one=1
while [[ $cdate -le $edate ]] ; do
while [[ ! -f $diagdir/radstat.gdas.$cdate ]] ; do
cdate=`$ndate +06 $cdate`
if [ $cdate -ge $edate ] ; then
break
fi
done
cdate=`$ndate +06 $cdate`
nt=$((nt+one))
done
dattot=$nt
cp unpack_rads.sh $wrkdir
cp par_run.sh $wrkdir
cp sort_diags.sh $wrkdir
cp ../../exec/cov_calc $wrkdir
cd $wrkdir
num_jobs=$num_proc
if [ $num_proc -ge $nt ] ; then
num_jobs=$nt
fi
jobs_per_proc=$((nt/num_jobs))
last_proc_jobs=$((nt-jobs_per_proc*num_jobs+jobs_per_proc))
nt=1
cdate=$bdate
while [[ $nt -le $num_jobs ]] ; do
nd=1
date1=$cdate
jobsn=$jobs_per_proc
if [ $nt -eq $num_jobs ] ; then
jobsn=$last_proc_jobs
fi
while [[ $nd -lt $jobsn ]] ; do
while [[ ! -f $diagdir/radstat.gdas.$cdate ]] ; do
cdate=`$ndate +06 $cdate`
if [ $cdate -gt $edate ] ; then
break
fi
done
nd=$((nd + one))
cdate=`$ndate +06 $cdate`
done
date2=$cdate
numin=$((nt - one))
coun=1
if [[ $numin -gt 0 ]] ; then
numin=$((numin*jobs_per_proc))
fi
numin=$((numin + one))
cat << EOF > params.sh
bdate=$date1
edate=$date2
start_nt=$numin
ndate=$ndate
wrkdir=$wrkdir
diagdir=$diagdir
instr=$instr
netcdf=$netcdf
EOF
chmod +rwx params.sh
cat unpack_rads.sh >> params.sh
mv params.sh unpack_rads_${nt}.sh
nt=$((nt + one))
cdate=`$ndate +06 $cdate`
done
cat << EOF > jobchoice.sh
nt=\$1
one=1
njobs=$jobs_per_proc
./unpack_rads_\${nt}.sh
EOF
chmod +rwx jobchoice.sh
if [ $machine = theia ] ; then
cat << EOF > jobarray.sh
cd $wrkdir
./jobchoice.sh \${SLURM_ARRAY_TASK_ID}
EOF
jobid=$(sbatch jobarray.sh)
elif [ $machine = wcoss ] ; then
cat << EOF > jobarray.sh
cd $wrkdir
echo ${LSB_JOBINDEX}
./jobchoice.sh \${LSB_JOBINDEX}
EOF
bsub < jobarray.sh
else
echo cannot submit job, not on theia or wcoss
exit 1
fi
if [ $machine = theia ] ; then
cat << EOF > params.sh
wrkdir=$wrkdir
ntot=$dattot
EOF
chmod +rwx params.sh
cat sort_diags.sh >> params.sh
mv params.sh sort_diags.sh
jobid=$(sbatch sort_diags.sh )
elif [ $machine = wcoss ] ; then
cat << EOF > params.sh
wrkdir=$wrkdir
ntot=$dattot
EOF
chmod +rwx params.sh
cat sort_diags.sh >> params.sh
mv params.sh sort_diags.sh
bsub -w "done(unpack)" < sort_diags.sh
else
exit 1
fi
if [ $machine = theia ] ; then
cat << EOF > params.sh
bdate=$bdate
edate=$edate
instr=$instr
diagdir=$diagdir
wrkdir=$wrkdir
savdir=$savdir
type=$type
cloud=$cloud
angle=$angle
wave_out=$wave_out
err_out=$err_out
corr_out=$corr_out
kreq=$kreq
method=$method
cov_method=$cov_method
time_sep=$time_sep
bsize=$bsize
bcen=$bcen
chan_set=$chan_set
ntot=$dattot
NP=$NP
netcdf=$netcdf
EOF
chmod +rwx params.sh
cat par_run.sh >> params.sh
mv params.sh par_run.sh
sbatch par_run.sh
elif [ $machine = wcoss ] ; then
cat << EOF > params.sh
bdate=$bdate
edate=$edate
instr=$instr
diagdir=$diagdir
wrkdir=$wrkdir
savdir=$savdir
type=$type
cloud=$cloud
angle=$angle
wave_out=$wave_out
err_out=$err_out
corr_out=$corr_out
kreq=$kreq
method=$method
cov_method=$cov_method
time_sep=$time_sep
bsize=$bsize
netcdf=$netcdf
bcen=$bcen
chan_set=$chan_set
ntot=$dattot
NP=$NP
EOF
chmod +rwx params.sh
cat par_run.sh >> params.sh
mv params.sh par_run.sh
bsub -w "done(sort_diag)" < par_run.sh
else
exit 1
fi
exit 0
