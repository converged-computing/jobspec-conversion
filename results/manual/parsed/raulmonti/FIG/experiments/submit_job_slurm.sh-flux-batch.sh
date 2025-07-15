#!/bin/bash
#FLUX: --job-name=boopy-general-9013
#FLUX: -c=24
#FLUX: --queue=main
#FLUX: -t=346320
#FLUX: --priority=16

export MAXJOBSN='24  # must equal value of "--cpus-per-task'

export MAXJOBSN=24  # must equal value of "--cpus-per-task"
if [ $# -ne 1 ] || [ ! -f $1 ]; then
	echo "[ERROR] Must invoke through \"enqueue_job.sh\"";
	exit 1;
fi
set +e;
module load gcc;
module load bison;
CWD=$PWD;
cd `dirname $1`;
srun -o %j.out -e %j.err /bin/bash `basename $1`;
cd $CWD;
exit 0;
