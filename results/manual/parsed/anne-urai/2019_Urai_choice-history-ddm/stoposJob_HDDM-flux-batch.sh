#!/bin/bash
#FLUX: --job-name=eccentric-pastry-4143
#FLUX: --priority=16

module load stopos
source activate python27 # use anaconda
ncores=`sara-get-num-cores` # 16 in total on LISA normal nodes
((ncores -= 1)) # subtract one for system processes, will have 15
echo "ncores = $ncores"
for ((i=1; i<=ncores; i++)) ; do
(
  for ((j=1; j<=1; j++)) ; do
     stopos next -p pool
       if [ "$STOPOS_RC" != "OK" ]; then
        break
     fi
    echo "Running with parameters: $STOPOS_VALUE"
    # see https://userinfo.surfsara.nl/systems/lisa/software/stopos
    a=( $STOPOS_VALUE )
    d=${a[0]}
    v=${a[1]}
    i=${a[2]}
    s=${a[3]}
    # first, run the model
 	  eval "python /home/aeurai/code/serialDDM/fitHDDM.py -r 1 -d $d -v $v -i $i -s $s"
    stopos remove -p pool
stopos status -p pool
   done
 ) &
done
wait
