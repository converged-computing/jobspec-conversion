#!/bin/bash
#FLUX: --job-name=evasive-truffle-5070
#FLUX: --urgency=16

export K8S_PORT='$K8S_PORT'
export K8S_CLUSTER_NAME='$K8S_CLUSTER_NAME'
export K8S_CLUSTER_API='$K8S_CLUSTER_API'
export K8S_CLUSTER_API_TOKEN='$K8S_CLUSTER_API_TOKEN'

set -x # Print each command before execution
set -e # fail and abort script if one command fails
set -o pipefail
if [ -z "$1" ]; then
    echo "Missing argument: Script is not specified. Pass a path to a script." >&2
    exit 1
fi
if [ ! -f "$1" ]; then
    echo "File does not exists for passed path" >&2
    exit 2
fi
if [ "$(stat -fc %T /sys/fs/cgroup/)" = "cgroup2fs" ]; then
    echo "cgroups v2 check passed: cgroups v2 is enabled"
else
    echo "cgroups v2 check failed: cgroups v2 is not enabled" >&2
    exit 3
fi
if [ -x "$(which podman)" ]; then
    echo "podman check passed"
else
    echo "podman check failed: podman not installed or not available in shell" >&2
    exit 4
fi
if [ -x "$(which kubectl)" ]; then
    echo "kubectl check passed"
else
    echo "kubectl check failed: kubectl not installed or not available in shell" >&2
    exit 4
fi
if [ -x "$(which kind)" ]; then
    echo "kind check passed"
else
    echo "kind check failed: kind not installed or not available in shell" >&2
    exit 4
fi
if [ -f /etc/os-release ]
then
    . /etc/os-release
    # vars listed in /etc/os-release are now available as ENV vars
    echo "Successfully read /etc/os-release"
else
    echo "Warn: file /etc/os-release not present. Can not determine OS version. Proceeding with default procedure" >&2
fi
function random_unused_port {
  local port
  for ((port=30000; port<=32767; port++)); do
      ss -Htan | awk '{print $4}' | cut -d':' -f2 | grep "$port" > /dev/null
      if [[ $? == 1 ]] ; then
          echo "$port"
          break
      fi
  done
}
cluster_name="$(uuidgen | tr -d '-' | head -c5)"
: "${K8S_PORT:=$(random_unused_port)}" # if K8S_PORT is not set
export K8S_PORT=$K8S_PORT
echo "K8S_PORT=$K8S_PORT"
function cleanup () {
  echo "Deleting Kind cluster container $cluster_name"
  # Delete kind Kubernetes cluster ------------------------
  if [[ "$NAME" == "CentOS Stream" && "$VERSION_ID" = "8" ]]; then
    # On some distributions, you might need to use systemd-run to start kind into its own cgroup scope
    KIND_EXPERIMENTAL_PROVIDER=podman systemd-run --scope --user kind delete cluster --name "$cluster_name"
  else
      # https://kind.sigs.k8s.io/docs/user/quick-start/
    KIND_EXPERIMENTAL_PROVIDER=podman kind delete cluster --name "$cluster_name"
  fi
}
trap cleanup EXIT # Normal Exit
trap cleanup SIGTERM # Termination
trap cleanup SIGINT # CTRL + C
echo "Kind config:"
envsubst < kind-config-template.yaml
if [[ "$NAME" == "CentOS Stream" && "$VERSION_ID" = "8" ]]; then
  # On some distributions, you might need to use systemd-run to start kind into its own cgroup scope:
  envsubst < kind-config-template.yaml | KIND_EXPERIMENTAL_PROVIDER=podman systemd-run --scope --user kind create cluster --name "$cluster_name" --wait 5m --config -
else
  envsubst < kind-config-template.yaml | KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster --name "$cluster_name" --wait 5m --config -
fi
kubectl get nodes --context "kind-$cluster_name"
kubectl cluster-info --context "kind-$cluster_name"
K8S_CLUSTER_NAME="kind-$cluster_name"
export K8S_CLUSTER_NAME=$K8S_CLUSTER_NAME
K8S_CLUSTER_API=$(kubectl config view -o jsonpath="{.clusters[?(@.name=='$K8S_CLUSTER_NAME')].cluster.server}")
export K8S_CLUSTER_API=$K8S_CLUSTER_API
kubectl --context "$K8S_CLUSTER_NAME" create -f -  <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
EOF
kubectl --context "$K8S_CLUSTER_NAME" create -f -  <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
EOF
K8S_CLUSTER_API_TOKEN=$(kubectl --context "$K8S_CLUSTER_NAME" -n kube-system create token admin-user)
export K8S_CLUSTER_API_TOKEN=$K8S_CLUSTER_API_TOKEN
echo "Executing the Kubernetes workload script $1 on cluster kind-$cluster_name"
/bin/bash "$1" &
wait # wait for background process. Fix for not working signal handling in Slurm (See https://docs.gwdg.de/doku.php?id=en:services:application_services:high_performance_computing:running_jobs_slurm:signals)
