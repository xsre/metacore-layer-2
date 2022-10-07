---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: "${cluster_name}"
  region: "${region}"
  version: "${eks_version}"

iam:
  withOIDC: true

vpc:
  id: "${vpc_id}"
  cidr: "${vpc_cidr}"
  subnets:
    # must provide 'private' and/or 'public' subnets by availibility zone as shown
    private:
      "${region}a":
        id: "${private-subnet-0}"
        cidr: "${private-subnet-0-cidr}"
      "${region}b":
        id: "${private-subnet-1}"
        cidr: "${private-subnet-1-cidr}"
      "${region}c":
        id: "${private-subnet-2}"
        cidr: "${private-subnet-2-cidr}"

addons:
- name: vpc-cni
  version: latest
- name: coredns
  version: latest
- name: kube-proxy
  version: latest
- name: aws-ebs-csi-driver
  version: latest

managedNodeGroups:
  # DUCES/LEADERS - CLUSTER OPERATORS
  - name: duces-mgd-wnp1-private-a
    instanceName: ${cluster_name}-dux-wnp-3-a
    instanceSelector:
      vCPUs: 8
      memory: 16GiB #
      cpuArchitecture: x86_64 # default value
    minSize: 1
    desiredCapacity: 1
    maxSize: 10
    availabilityZones: ["${region}a"]
    privateNetworking: true
    volumeSize: 100
    updateConfig:
      maxUnavailablePercentage: 50
    ssh:
      allow: false
    labels:
      apis: duces
    tags:
      k8s.io/cluster-autoscaler/node-template/label/apis: duces
    iam:
      withAddonPolicies:
        autoScaler: true
        cloudWatch: true
        externalDNS: false
        certManager: true
        ebs: true

  # DUCES/LEADERS - CLUSTER OPERATORS
  - name: duces-mgd-wnp1-private-b
    instanceName: ${cluster_name}-dux-wnp-3-b
    instanceSelector:
      vCPUs: 8
      memory: 16GiB #
      cpuArchitecture: x86_64 # default value
    minSize: 1
    desiredCapacity: 1
    maxSize: 10
    availabilityZones: ["${region}b"]
    privateNetworking: true
    volumeSize: 100
    updateConfig:
      maxUnavailablePercentage: 50
    ssh:
      allow: false
    labels:
      apis: duces
    tags:
      k8s.io/cluster-autoscaler/node-template/label/apis: duces
    iam:
      withAddonPolicies:
        autoScaler: true
        cloudWatch: true
        externalDNS: false
        certManager: true
        ebs: true

  # DUCES/LEADERS - CLUSTER OPERATORS
  - name: duces-mgd-wnp1-private-c
    instanceName: ${cluster_name}-dux-wnp-3-c
    instanceSelector:
      vCPUs: 8
      memory: 16GiB #
      cpuArchitecture: x86_64 # default value
    minSize: 1
    desiredCapacity: 1
    maxSize: 10
    availabilityZones: ["${region}c"]
    privateNetworking: true
    volumeSize: 100
    updateConfig:
      maxUnavailablePercentage: 50
    ssh:
      allow: false
    labels:
      apis: duces
    tags:
      k8s.io/cluster-autoscaler/node-template/label/apis: duces
    iam:
      withAddonPolicies:
        autoScaler: true
        cloudWatch: true
        externalDNS: false
        certManager: true
        ebs: true

  # PLEBIS/WORKERS - APPLICATION STATEFUL WORKLOADS
  - name: plebis-mgd-wnp2-private-a
    instanceName: ${cluster_name}-pleb-wnp-2-a
    instanceSelector:
      vCPUs: 8
      memory: 16GiB #
      cpuArchitecture: x86_64 # default value
    minSize: 1
    desiredCapacity: 1
    maxSize: 10
    availabilityZones: ["${region}a"]
    privateNetworking: true
    volumeSize: 100
    updateConfig:
      maxUnavailablePercentage: 50
    ssh:
      allow: false
    labels:
      apis: plebis
    tags:
      k8s.io/cluster-autoscaler/node-template/label/apis: plebis
    iam:
      withAddonPolicies:
        autoScaler: true
        cloudWatch: true
        externalDNS: false
        certManager: true
        ebs: true

  # PLEBIS/WORKERS - APPLICATION STATEFUL WORKLOAD
  - name: plebis-mgd-wnp2-private-b
    instanceName: ${cluster_name}-pleb-wnp-2-b
    instanceSelector:
      vCPUs: 8
      memory: 16GiB #
      cpuArchitecture: x86_64 # default value
    minSize: 1
    desiredCapacity: 1
    maxSize: 10
    availabilityZones: ["${region}b"]
    privateNetworking: true
    volumeSize: 100
    updateConfig:
      maxUnavailablePercentage: 50
    ssh:
      allow: false
    labels:
      apis: plebis
    tags:
      k8s.io/cluster-autoscaler/node-template/label/apis: plebis
    iam:
      withAddonPolicies:
        autoScaler: true
        cloudWatch: true
        externalDNS: false
        certManager: true
        ebs: true

  # PLEBIS/WORKERS - APPLICATION STATEFUL WORKLOAD
  - name: plebis-mgd-wnp2-private-c
    instanceName: ${cluster_name}-pleb-wnp-2-c
    instanceSelector:
      vCPUs: 8
      memory: 16GiB #
      cpuArchitecture: x86_64 # default value
    minSize: 1
    desiredCapacity: 1
    maxSize: 10
    availabilityZones: ["${region}c"]
    privateNetworking: true
    volumeSize: 100
    updateConfig:
      maxUnavailablePercentage: 50
    ssh:
      allow: false
    labels:
      apis: plebis
    tags:
      k8s.io/cluster-autoscaler/node-template/label/apis: plebis
    iam:
      withAddonPolicies:
        autoScaler: true
        cloudWatch: true
        externalDNS: false
        certManager: true
        ebs: true

  # FUCI/SPOT - APPLICATION STATELESS WORKLOAD
  - name: fuci-mgd-wnp3-private
    instanceName: ${cluster_name}-fucus-wnp-3
    privateNetworking: true
    minSize: 1
    maxSize: 30
    instanceTypes: ["c5.4xlarge","c4.4xlarge","t3.2xlarge"]
    spot: true
    iam:
      withAddonPolicies:
        autoScaler: true
        cloudWatch: true
        externalDNS: false
        certManager: false
        ebs: true
    labels:
      apis: fuci
    tags:
      k8s.io/cluster-autoscaler/node-template/label/apis: fuci


secretsEncryption:
  # KMS key used for envelope encryption of Kubernetes secrets
  keyARN: "${kms}"

cloudWatch:
  clusterLogging:
    # enable specific types of cluster control plane logs
    enableTypes: ["api", "audit", "authenticator", "controllerManager"]
    # all supported types: "api", "audit", "authenticator", "controllerManager", "scheduler"
    # supported special values: "*" and "all"