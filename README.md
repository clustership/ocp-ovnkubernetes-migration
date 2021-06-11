# Ansible playbook to migrate OpenShift 4 from OpenShiftSDN to OVNKubernetes

## Purpose

Automation of migration from OpenShiftSDN SDN provider to OVNKubernetes

Follow the steps from the [OpenShift documentation](https://docs.openshift.com/container-platform/4.7/networking/ovn_kubernetes_network_provider/migrate-from-openshift-sdn.html)
## Usage

Copy cluster.yaml.example file to cluster.yaml. Adjust the cluster.yaml file to fit your cluster configuration (cluster name and dns domain).

```bash
cp cluster.yaml.example cluster.yaml
vi cluster.yaml
```


```
# cluster.yaml
cluster_name: mycluster
public_domain: mypublicdomain.com
```

Then run the ansible script:

```bash
cd ansible
./01-migrate-to-ovnkubernetes.sh
```

Wait for successful installation of OVNKubernetes.

## Validation

Check that OVNKubernetes is your default SDN provider:

```bash
oc get network.config/cluster -o jsonpath='{.status.networkType}{"\n"}'
```


Confirm that no pods are in error state:

```bash
oc get pods --all-namespaces -o wide --sort-by='{.spec.nodeName}'
```

# Tested on

* OpenShift 4.7 and 4.8 on Bare Metal
* OpenShift 4.8 on Red Hat OpenStack 16
* OpenShift 4.8 on AWS

