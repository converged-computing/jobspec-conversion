#!/bin/bash
#FLUX: --job-name=ali-perf
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: -t=3540
#FLUX: --urgency=16

                                      #            short: 4hrs wallclock limit
                                      #            batch: nodes reserved for > 4hrs (default)
                                      #            short,batch: job will move to batch if short is full
                                      #           normal: request up to 48hrs wallclock (default)
                                      #           long:   request up to 96hrs wallclock and no larger than 64nodes
                                      #           large:  greater than 50% of cluster (special request)
                                      #           priority: High priority jobs (special request)
nodes=$SLURM_JOB_NUM_NODES           # Number of nodes - the number of nodes you have requested (for a list of SLURM environment variables see "man sbatch")
cores=96                             # Number MPI processes to run on each node (a.k.a. PPN)
                                     # tlcc2 has 16 cores per node
unset http_proxy
unset https_proxy
bash nightly_cron_script_ali_perf_tests_blake_run.sh
bash process_results_ctest.sh 
bash nightly_cron_script_ali_perf_tests_blake_bzip2_save.sh >& nightly_log_blakeALIPerfTests_saveResults.txt
