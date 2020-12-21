
## mx51 Custom Helm Charts

Add the EKS repository to Helm:

```sh
helm repo add eks http://code.mx51.io/helm-chart-packages/
```

### AWS Calico

* [aws-calico](stable/aws-calico): Install Calico network policy enforcement on AWS
* [metabase](stable/metabase): Install Metabase

### Local testing

```sh
# For example to generate the template for Metabase
helm template metabase stable/metabase -n data -f stable/metabase/values.yaml --set serviceAccount.create=true
```
