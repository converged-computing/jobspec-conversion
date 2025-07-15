#!/bin/bash
#FLUX: --job-name=2_t2_runner
#FLUX: -N=2
#FLUX: --queue=cpu
#FLUX: -t=1209600
#FLUX: --priority=16

module load tools/git/2.18.0
module load languages/gcc/9.3.0
module load apps/matlab/2018a
module load gc/7.4.4-foss-2016a
cd $SLURM_SUBMIT_DIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job ID is $SLURM_JOB_ID
echo This job runs on the following machines:
echo `echo $SLURM_JOB_NODELIST | uniq`
module load languages/intel/2020-u4
start=`date +%s`
mpirun -np 56 ./t2_runner
echo Time is `date`
end=`date +%s`
runtime=`echo "$end - $start" |bc`
function show_time () {
  num=$1
  min=0
  hour=0
  day=0
  sec=0
  if((num>59));then
    ((sec=num%60))
    ((num=num/60))
    if((num>59));then
      ((min=num%60))
      ((num=num/60))
      if((num>23));then
        ((hour=num%24))
        ((day=num/24))
      else
        ((hour=num))
      fi
    else
      ((min=num))
    fi
  else
    ((sec=num))
  fi
  echo "$day"d "$hour"h "$min"m "$sec"s
}
show_time $runtime
