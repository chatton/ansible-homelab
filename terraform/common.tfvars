# Shared across every terraform/* project via a common.auto.tfvars symlink in
# each directory (Terraform auto-loads *.auto.tfvars, no -var-file flag needed).
# Edit here once, every project picks it up.
qnap = "10.4.5.200"
dell = "10.4.5.201"
