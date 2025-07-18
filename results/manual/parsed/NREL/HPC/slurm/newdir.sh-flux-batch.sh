#!/bin/bash
#FLUX: --job-name=hybrid
#FLUX: -N=2
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

:<<++++
Author: Tim Kaiser
This script is about creating records of what you are
doing.
It:
  creates a new directory for each run and goes there
  makes a copy of the run script
  makes a copy of the input
  saves the environment
  saves a copy of the executable
  saves a copy of stdout and stderr to the directory.  
It also shows how you can use variables for your
program name ($EXE), input file ($INPUT) and argument
list ($ARGS)
USAGE:
    sbatch -A hpcapps --partition=debug newdir.sh 
++++
module load mpt
cd $SLURM_SUBMIT_DIR
JOBID=`echo $SLURM_JOBID`
MYBASE=$SLURM_SUBMIT_DIR
mkdir -p $MYBASE/$JOBID
cd $MYBASE/$JOBID
ln -s $SLURM_SUBMIT_DIR submit
cat $0 > script.$JOBID
printenv  > env.$JOBID
scontrol show hostnames > nodes.$JOBID
EXE=$SLURM_SUBMIT_DIR/stf_01
cp $EXE .
ARGS="arg1 arg2 arg3"
INPUT=st.in
cp $SLURM_SUBMIT_DIR/$INPUT .
echo "running job"
srun $EXE $ARGS < $INPUT > output.$JOBID
echo "job has finished"
echo "run in" `pwd` " produced the files:"
ls -lt 
cp $SLURM_SUBMIT_DIR/slurm-$JOBID.out .
:<<++++
Example output
el2:collect> sbatch -A hpcapps --partition=debug newdir.sh 
Submitted batch job 5369986
el2:collect> 
el2:collect> cd 5369986
el2:5369986> 
el2:5369986> ls -l
total 1032
-rw-rw----. 1 tkaiser2 tkaiser2    6365 Dec 18 10:03 env.5369986
-rw-rw----. 1 tkaiser2 tkaiser2      16 Dec 18 10:03 nodes.5369986
-rw-rw----. 1 tkaiser2 tkaiser2    1283 Dec 18 10:03 output.5369986
-rw-rw----. 1 tkaiser2 tkaiser2    6100 Dec 18 10:03 script.5369986
-rw-rw----. 1 tkaiser2 tkaiser2     565 Dec 18 10:03 slurm-5369986.out
-rwxrwx---. 1 tkaiser2 tkaiser2 1006552 Dec 18 10:03 stf_01
-rw-r-----. 1 tkaiser2 tkaiser2      54 Dec 18 10:03 st.in
lrwxrwxrwx. 1 tkaiser2 tkaiser2      22 Dec 18 10:03 submit -> /home/tkaiser2/collect
el2:5369986> 
el2:5369986> 
el2:5369986> head env.5369986 
SLURM_NODELIST=r103u[21,23]
SLURM_JOB_NAME=hybrid
XDG_SESSION_ID=221388
SLURMD_NODENAME=r103u21
SLURM_TOPOLOGY_ADDR=root.r103.r103u21
SLURM_NTASKS_PER_NODE=8
HOSTNAME=r103u21
SPACK_ROOT=/home/tkaiser2/spack/spack
SLURM_PRIO_PROCESS=0
el2:5369986> 
el2:5369986> cat nodes.5369986 
r103u21
r103u23
el2:5369986> 
el2:5369986> cat output.5369986 
 command line argument            1 arg1
 command line argument            2 arg2
 command line argument            3 arg3
myid=    8    (  1 <= i <= 200) ,  (101 <= j <= 113)
rows=   16
myid=    0    (  1 <= i <= 200) ,  (  1 <= j <=  13)
myid=    1    (  1 <= i <= 200) ,  ( 14 <= j <=  25)
myid=    2    (  1 <= i <= 200) ,  ( 26 <= j <=  38)
myid=    3    (  1 <= i <= 200) ,  ( 39 <= j <=  50)
myid=    4    (  1 <= i <= 200) ,  ( 51 <= j <=  63)
myid=    5    (  1 <= i <= 200) ,  ( 64 <= j <=  75)
myid=    6    (  1 <= i <= 200) ,  ( 76 <= j <=  88)
myid=    7    (  1 <= i <= 200) ,  ( 89 <= j <= 100)
myid=    9    (  1 <= i <= 200) ,  (114 <= j <= 125)
myid=   10    (  1 <= i <= 200) ,  (126 <= j <= 138)
myid=   11    (  1 <= i <= 200) ,  (139 <= j <= 150)
myid=   13    (  1 <= i <= 200) ,  (164 <= j <= 175)
myid=   14    (  1 <= i <= 200) ,  (176 <= j <= 188)
myid=   15    (  1 <= i <= 200) ,  (189 <= j <= 200)
myid=   12    (  1 <= i <= 200) ,  (151 <= j <= 163)
  7500      28787803.56    
 15000      1317237.087    
 22500      42635.75565    
 30000      1281.662011    
 37500      37.85422269    
 45000      1.113138052    
 52500     0.3269575697E-01
 60000     0.9595943866E-03
 67500     0.1163160778E-04
 75000      0.000000000    
run time =      0.88
el2:5369986> 
el2:5369986> head script.5369986 
el2:5369986> 
el2:5369986> cat slurm-5369986.out 
running job
job has finished
run in /home/tkaiser2/collect/5369986  produced the files:
total 1028
-rw-rw---- 1 tkaiser2 tkaiser2    1283 Dec 18 10:03 output.5369986
-rw-r----- 1 tkaiser2 tkaiser2      54 Dec 18 10:03 st.in
-rwxrwx--- 1 tkaiser2 tkaiser2 1006552 Dec 18 10:03 stf_01
-rw-rw---- 1 tkaiser2 tkaiser2      16 Dec 18 10:03 nodes.5369986
-rw-rw---- 1 tkaiser2 tkaiser2    6365 Dec 18 10:03 env.5369986
-rw-rw---- 1 tkaiser2 tkaiser2    6100 Dec 18 10:03 script.5369986
lrwxrwxrwx 1 tkaiser2 tkaiser2      22 Dec 18 10:03 submit -> /home/tkaiser2/collect
el2:5369986> 
++++
