variable "aws_region" {
  description = "AWS region to deploy into. Must match the AWS_REGION GitHub variable."
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application name, used as a prefix for every resource."
  type        = string
  default     = "notesy"
}

variable "environment" {
  description = "Environment name (tag only)."
  type        = string
  default     = "dev"
}

# ---------------------------------------------------------------- network ---

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

# ------------------------------------------------------------------- app ----

variable "container_port" {
  description = "Port gunicorn listens on inside the container (see Dockerfile EXPOSE)."
  type        = number
  default     = 8000
}

variable "image_tag" {
  description = "Image tag used for the initial task definition. CI replaces it with the commit SHA on each deploy."
  type        = string
  default     = "latest"
}

variable "task_cpu" {
  description = "Fargate task CPU units (256 = 0.25 vCPU)."
  type        = number
  default     = 512
}

variable "task_memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Number of running tasks. Set to 0 until the first image is pushed to ECR."
  type        = number
  default     = 1
}

variable "django_allowed_hosts" {
  description = "Value for DJANGO_ALLOWED_HOSTS. ALB health checks send the task's private IP as the Host header, so restrict this only if you also handle that."
  type        = string
  default     = "*"
}

variable "run_seed" {
  description = "Run `manage.py seed` (creates the demo/demo user) on container start."
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch log retention for the app container."
  type        = number
  default     = 14
}

# -------------------------------------------------------------- database ----

variable "db_name" {
  description = "Postgres database name."
  type        = string
  default     = "notesy"
}

variable "db_username" {
  description = "Postgres master username."
  type        = string
  default     = "notesy"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "RDS storage in GiB."
  type        = number
  default     = 20
}

variable "db_deletion_protection" {
  description = "Protect the RDS instance from `terraform destroy`."
  type        = bool
  default     = false
}

# ---------------------------------------------------------------- GitHub ----

variable "github_repository" {
  description = "GitHub repo allowed to assume the deploy role, as \"owner/name\"."
  type        = string
}

variable "github_branch" {
  description = "Branch allowed to deploy."
  type        = string
  default     = "main"
}

variable "create_github_oidc_provider" {
  description = "Create the GitHub OIDC provider. Set false if it already exists in the account (only one per account is allowed)."
  type        = bool
  default     = true
}
