#!/bin/bash

let nnds=8
#--- process processexe.pl to change the number of nodes
./processcp.pl ${nnds}

#-----This part creates a submission script---------
cat >batch.job <<EOF
#!/bin/bash
#COBALT -n ${nnds} -t 60 -O runs${nnds} -qdebug-cache-quad  -A EE-ECP

module use -a /projects/intel/geopm-home/modulefiles
module unload darshan
module load geopm/1.x

module load miniconda-3/latest
source activate yt

python3 -m ytopt.search.ambs --evaluator ray --problem problem.Problem --max-evals=200 --learner RF
conda deactivate

EOF
#-----This part submits the script you just created--------------
chmod +x batch.job
qsub batch.job
