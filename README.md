# flexvolume-ebs
[FlexVolume](https://github.com/kubernetes/community/blob/master/contributors/devel/flexvolume.md) Plugin For AWS EBS

# Features
- Target EBS volumes to be mounted on a specified AZ
- Auto detect attachment and mount devices
- Works with new NVME EC2 instance types(C5, M5, T3, etc)
- Supports XFS filesystem
- Auto resize at mount time using xfs_grow

# Requirements

## Kubernetes Master
- kube-controller-manager --flex-volume-plugin-dir=/var/lib/kubelet/volumeplugins
- [IAM Role](example/iam_role.json) and [IAM Role Policy](example/iam_role_policy.json)
- Set REGION env variable, e.g. ```export REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -c -r .region)```

## Kubernetes Nodes
- kubelet --volume-plugin-dir=/var/lib/kubelet/volumeplugins
- kubelet --node-labels=failure-domain.beta.kubernetes.io/zone=$AZ

## EBS Volumes
- Must have Name tag, e.g. ```Name="volume1"```

## Persistent Volumes
- Name PV to be the same as the EBS name tag, e.g. ```name: volume1```
- Label the target AZ, e.g. ```failure-domain.beta.kubernetes.io/zone: us-west-2a```
- Add flexvolume configuration
- Note the storage capacity value is needed for validation but is not used at runtime
- [Sample PV](example/persistent-volume.yml)

## Persistent Volume Claim
- Set volume name to be same as the PV name
- Note the storage capacity value is needed for validation but is not used at runtime
- [Sample PVC](example/persistent-volume-claim.yml)

# Installation

[Deployment using DaemonSet](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/storage/flexvolume-deployment.md#recommended-driver-deployment-method)

[flexvolume-es-daemonset.yml](example/flexvolume-es-daemonset.yml)
