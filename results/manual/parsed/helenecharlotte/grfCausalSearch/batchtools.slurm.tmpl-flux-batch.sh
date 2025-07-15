#!/bin/bash
#FLUX: --job-name=<%= job.name %>
#FLUX: -c=24
#FLUX: -t=3600
#FLUX: --priority=16

export DEBUGME='<%= Sys.getenv("DEBUGME") %>'

<%
log.file = fs::path_expand(log.file)
-%>
<%= if (!is.null(resources$partition)) sprintf(paste0("#SBATCH --partition='", resources$partition, "'")) %>
<%= if (array.jobs) sprintf("#SBATCH --array=1-%i", nrow(jobs)) else "" %>
module load gcc
module load R
export DEBUGME=<%= Sys.getenv("DEBUGME") %>
<%= sprintf("export OMP_NUM_THREADS=%i", resources$omp.threads) -%>
<%= sprintf("export OPENBLAS_NUM_THREADS=%i", resources$blas.threads) -%>
<%= sprintf("export MKL_NUM_THREADS=%i", resources$blas.threads) -%>
Rscript -e 'batchtools::doJobCollection("<%= uri %>")'
