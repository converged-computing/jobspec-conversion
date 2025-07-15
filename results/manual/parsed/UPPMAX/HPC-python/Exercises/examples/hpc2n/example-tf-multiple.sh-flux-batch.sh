#!/bin/bash
#FLUX: --job-name=stanky-staircase-1368
#FLUX: -t=300
#FLUX: --priority=16

module purge  > /dev/null 2>&1
module load GCC/11.3.0  OpenMPI/4.1.4 TensorFlow/2.11.0-CUDA-11.7.0 scikit-learn/1.1.2
python <my_tf_program.py> <param1> <param2> > myoutput1 2>&1
cp myoutput1 mydatadir
python <my_tf_program.py> <param3> <param4> > myoutput2 2>&1
cp myoutput2 mydatadir
python <my_tf_program.py> <param5> <param6> > myoutput3 2>&1
cp myoutput3 mydatadir
