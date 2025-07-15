#!/bin/bash
#FLUX: --job-name=tephra2
#FLUX: --queue=veryshort
#FLUX: -t=10800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load languages/intel/2018-u3
module load tools/git/2.18.0
module load languages/gcc/9.3.0
module load apps/matlab/2018a
module load gc/7.4.4-foss-2016a
options="-nodesktop -noFigureWindows -nosplash"
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job IS is $SLURM_JOBID
echo This job runs on the following machines:
echo $SLURM_JOB_NODELIST
echo -e "\n"
echo --------------------- START ---------------------
echo -e "\n"
start=`date +%s`
./tephra2_2020 inputs/tephra2.conf ../grid/krak.utm  ../wind/gen_files/262000/262000_2012_12_31_18.gen > tephra2_krak_test.out
echo -e "\n"
echo --------------------- FINISH ---------------------
echo -e "\n"
echo Finish time is `date`
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
