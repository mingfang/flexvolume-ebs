# flexvolume-ebs
FlexVolume Plugin For AWS EBS

docker/ebs -> docker -> flexvolume-ebs/ebs -> AWS CLI

[Deployment using DaemonSet](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/storage/flexvolume-deployment.md#recommended-driver-deployment-method)

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: flexvolume-ebs
spec:
  selector:
    matchLabels:
      daemonset: flexvolume-ebs
  template:
    metadata:
      labels:
        daemonset: flexvolume-ebs
        name: flexvolume-ebs
      name: flexvolume-ebs
    spec:
      containers:
      - name: flexvolume-ebs
        image: registry.rebelsoft.com/flexvolume-ebs:latest
        command:
        - /install.sh
        securityContext:
          privileged: true
        volumeMounts:
        - mountPath: /volumeplugins
          name: volumeplugins
      volumes:
      - name: volumeplugins
        hostPath:
          path: /var/lib/kubelet/volumeplugins
      tolerations:
      - effect: NoSchedule
        key: dedicated
        operator: Equal
        value: master
```