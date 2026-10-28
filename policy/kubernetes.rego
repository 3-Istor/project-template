# Platform rules checked by conftest on the rendered Kubernetes manifests.
# Each deny is a rule the platform team wants enforced on every app; add the
# project's own (allowed registries, required labels) below these.
package main

import rego.v1

workloads := {"Deployment", "StatefulSet", "DaemonSet", "Job", "CronJob"}

pod_spec := input.spec.template.spec if input.kind != "CronJob"

pod_spec := input.spec.jobTemplate.spec.template.spec if input.kind == "CronJob"

containers contains c if {
	workloads[input.kind]
	some c in pod_spec.containers
}

containers contains c if {
	workloads[input.kind]
	some c in pod_spec.initContainers
}

# A registry port (registry:5000/app) is not a tag: look at the last segment.
untagged(image) if {
	segments := split(image, "/")
	last := segments[count(segments) - 1]
	not contains(last, ":")
	not contains(last, "@")
}

deny contains msg if {
	some c in containers
	untagged(c.image)
	msg := sprintf("%s/%s: image %q has no tag", [input.kind, input.metadata.name, c.image])
}

deny contains msg if {
	some c in containers
	endswith(c.image, ":latest")
	msg := sprintf("%s/%s: image %q uses :latest", [input.kind, input.metadata.name, c.image])
}

deny contains msg if {
	some c in containers
	c.securityContext.privileged == true
	msg := sprintf("%s/%s: container %q is privileged", [input.kind, input.metadata.name, c.name])
}

deny contains msg if {
	some c in containers
	not c.resources.limits.memory
	msg := sprintf("%s/%s: container %q has no memory limit", [input.kind, input.metadata.name, c.name])
}
