Amazon Web Services

Chosen for:
Mature managed services (RDS, ALB, ASG)
Strong security primitives (IAM, SGs, private networking)
Native scalability and high availability
Broad industry adoption and best-practice reference architectures

Application Load Balancer (ALB)
Native L7 load balancing for HTTP/HTTPS
Health checks and AZ-level fault tolerance
Tight integration with Auto Scaling Groups

Why not NLB?
WordPress benefits from HTTP routing and health checks rather than raw TCP throughput.

Auto Scaling Group (EC2)
Horizontal scalability for variable traffic
Automatic recovery of unhealthy instances
Stateless application design simplifies scaling

Why EC2 over ECS/EKS?
Simpler operational model for WordPress
Faster to deploy and reason about in an assessment context
Avoids container orchestration overhead

Amazon RDS MySQL (Multi-AZ)
Managed backups, patching, and failover
Encryption at rest and in transit
Multi-AZ ensures high availability for stateful data

Why not Aurora?
Higher cost
Overkill for expected workload
RDS MySQL meets availability and performance needs

Amazon S3 for Media
Decouples media from EC2 lifecycle
Highly durable (11 9s)
Reduces instance storage and AMI complexity

Security Considerations & Implementations

Network Security:
VPC isolation
Public subnets: ALB only
Private subnets: EC2 and RDS
No direct internet access to application or database tiers
No broad CIDR rules
Security groups reference each other, not IPs

IAM & Secrets
IAM roles attached to EC2 (no hard-coded credentials)
Database credentials stored in Secrets Manager
Principle of least privilege enforced

Data Protection
RDS encryption at rest (KMS)
TLS in transit
Private DB subnet (not publicly accessible)

Scalability Approach

Horizontal Scaling
Auto Scaling Group (min 2, max 4 instances)
Scale based on:
  CPU utilization
  ALB request count

High Availability
Multi-AZ ALB
Multi-AZ RDS
Instances spread across AZs

Stateless Design
Media in S3
Config via user-data
Instances can be safely replaced at any time

Cost Optimization Strategies

Right-Sizing
t3.micro EC2 instances
db.t3.micro RDS for baseline workloads

Elastic Scaling
Pay only for required EC2 capacity
Scale down during low traffic

Managed Services
Reduced operational overhead → lower engineering cost
Avoids custom HA/backup implementations

Storage Optimization
S3 lifecycle policies (future enhancement)
No EBS over-provisioning

Trade-offs Made (Explicit & Intentional)

Decision	                          Trade-off
EC2 instead of containers	          Less modern, simpler ops
RDS MySQL vs Aurora	                  Lower performance ceiling, lower cost
NAT Gateway usage	                  Adds cost, enables secure outbound access
No Redis/ElastiCache	              Simpler architecture, lower complexity
No WAF initially	                  Faster delivery, can be added later