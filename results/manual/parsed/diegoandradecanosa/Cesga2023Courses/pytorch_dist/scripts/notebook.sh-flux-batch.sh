#!/bin/bash
#FLUX: --job-name=milky-buttface-2145
#FLUX: -c=24
#FLUX: --queue=cola-corta,thin-shared,thinnodes,gpu-shared-v100
#FLUX: -t=23400
#FLUX: --urgency=16

CUDA=
VERSION=1.0.0
PORT=8888
MAXPORT=9999
UNAME=`hostname`
IP=`grep -w $UNAME /etc/hosts | awk '{print $1}'| tail -1`
echo $IP
SERVING=`netstat -an | grep "$IP:$PORT"`
while [ -n "$SERVING" -a $PORT -lt $MAXPORT ]; 
do 
   PORT=`expr $PORT + 1`
   SERVING=`netstat -an | grep "$IP:$PORT"`
done
trap "kill  %1" INT 
[ -z $SLURM_JOB_ID ] && SLURM_JOB_ID=$BASHPID
echo "Starting server on $IP:$PORT\n"
mkdir -p $HOME/.jupyter
$CMDNOTEBOOK jupyter notebook --ip=$IP --port=$PORT --no-browser 3>&1 >> $HOME/.jupyter/$IP.$PORT &
echo "*********************************************************"
echo " "
echo "Waiting for Jupyter to start.....\n"
echo " "
echo "*********************************************************"
sleep 1
NEWADDR=`jupyter notebook list |grep ^http| tail -1 | cut -f1 -d" "`
while [ -z "$NEWADDR" ]
do
sleep 1
NEWADDR=`jupyter notebook list |grep ^http| tail -1 | cut -f1 -d" "`
done
URL=${SLURM_JOB_ID}-${PORT}.proxy.cesga.es
HAAS=`echo $NEWADDR| cut -d"?" -f2`
echo `curl -X POST --url http://10.112.0.20:8001/apis/ --data "request_host=$URL" --data "upstream_url=http://$IP:$PORT" --data "name=$URL" -s` | grep -v occu > /dev/null
if [ $? -gt 0 ]
then
echo "*********************************************************"
echo "Error starting Jupyter..."
echo "*********************************************************" 
exit
fi
echo "*********************************************************" | tee -a $HOME/.jupyter/server-${SLURM_JOB_ID}
echo " " | tee -a $HOME/.jupyter/server-${SLURM_JOB_ID}
wait
rm $HOME/.jupyter/server-${SLURM_JOB_ID} $HOME/.jupyter/$IP.$PORT
