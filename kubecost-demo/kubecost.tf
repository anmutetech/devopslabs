resource "null_resource" "update_config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
  }
  depends_on = [ module.eks ]
}


resource "helm_release" "kubecost" {
  name       = "kubecost"
  namespace = "kubecost"
  create_namespace = true
  force_update = true

  repository = "https://kubecost.github.io/cost-analyzer"
  chart      = "cost-analyzer"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  depends_on = [ null_resource.update_config ]
}