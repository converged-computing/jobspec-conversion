#!/bin/bash
#FLUX: --job-name=goodbye-avocado-2786
#FLUX: -N=5
#FLUX: -n=5
#FLUX: -c=8
#FLUX: --urgency=16

runlist=$1
mkfifo testfifo
exec 1000<>testfifo
rm -fr testfifo
rm p02.log
for ((n=1;n<=5;n++))
do
    echo >&1000
done
start=`date "+%s"`
cat $runlist | while read line
do
    read -u1000
    {
        #echo `date` "Now runing with $line">>p02.log
	srun -N1 -n1 -c8  -o ${line}.out -e ${line}.error sh $line
	#echo `date` "Now Job $line is done">>Job.log
        echo >&1000
    }&
done
sleep 30m
sh p03.combin.sh
wait
end=`date "+%s"`
echo "TIME: `expr $end - $start `"
exec 1000>&-
exec 1000<&-
