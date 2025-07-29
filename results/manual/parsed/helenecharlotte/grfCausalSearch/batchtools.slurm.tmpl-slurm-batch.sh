#!/bin/bash
#SBATCH --job-name=<%=
#SBATCH --output=<%=
#SBATCH --error=<%=
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=01:00:00

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
