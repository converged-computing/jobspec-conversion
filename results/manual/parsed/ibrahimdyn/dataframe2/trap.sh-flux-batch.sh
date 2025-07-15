#!/bin/bash
#FLUX: --job-name=anxious-hope-4293
#FLUX: -c=6
#FLUX: -t=864000
#FLUX: --priority=16

echo "cwd is"
echo $(pwd)
echo "database starting"
/hddstore/idayan/pgsql/data/bin/pg_ctl -D /hddstore/idayan/pgsql/data/c -l logfile start # node 3
source ~/envforTRAP/bin/activate
echo "jobname is:"
echo $1
echo "starting processing"
trap-manage.py run $1  -m "[[293.73,21.90], [293.73, 19.40],[293.73, 23.40],[291.43, 21.90]]"
