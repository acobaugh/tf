output "user-kubeconfig" {
	value = "${module.k8s.user-kubeconfig}"
}

output "cluster_name" {
	value = "${module.k8s.cluster_name}"
}
