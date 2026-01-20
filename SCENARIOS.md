1. Traffic Spike (10x Regular Traffic)

How the Current Architecture Handles It

Application Load Balancer (ALB) distributes incoming traffic across multiple Availability ones.
Auto Scaling Group (ASG) automatically scales EC2 instances horizontally based on CPU utilization and/or request count.
Stateless WordPress instances allow new instances to be added or removed without impacting users.
RDS Multi-AZ continues serving database traffic without manual intervention.

This design allows the platform to absorb sudden spikes without downtime, assuming database capacity is not saturated.

Improvements for Better Performance

Add CloudFront CDN to cache static content and reduce load on EC2 and ALB.
Introduce ElastiCache (Redis) for object and page caching to reduce database reads.
Use ALB request-based scaling instead of CPU-only metrics.
Pre-warm scaling policies or scheduled scaling for known traffic events.


2. Security Incident (Unauthorized Access Attempt)

Logging & Monitoring for Investigation
CloudWatch Logs for:
    ALB access logs
    EC2 system and application logs

VPC Flow Logs to identify suspicious network traffic patterns.
CloudTrail to audit API calls and detect IAM misuse.
RDS logs for failed authentication attempts.

These logs allow tracing the source IP, access vector, affected resources, and timeline of the incident.

Security Improvements to Implement

Enable AWS WAF on the ALB with OWASP Top 10 managed rules.
Add rate limiting and geo-blocking rules.
Enable GuardDuty for anomaly and threat detection.
Enforce AWS Systems Manager Session Manager and remove direct SSH access.
Rotate credentials and enforce stricter IAM policies after the incident.


3. Cost Optimization (30% Reduction Target)

Cost Reduction Actions (Without Sacrificing Reliability)

Right-size EC2 instances using CloudWatch metrics (e.g., move from t3.micro to t3.nano if feasible).
Reduce Auto Scaling minimum capacity during off-peak hours.
Purchase Compute Savings Plans for steady-state workloads.
Optimize RDS instance class or reduce backup retention where acceptable.
Introduce CloudFront caching to lower compute and bandwidth costs.
Review NAT Gateway usage and minimize unnecessary outbound traffic.

Expected Outcome
A combination of right-sizing, elastic scaling, and caching can realistically achieve a ~30% cost reduction while maintaining high availability.

4. Disaster Recovery (Primary Region Outage)

Disaster Recovery Process

a) Secondary Region Prepared:
      Pre-provisioned VPC, subnets, and security configurations (warm standby).

b) Data Replication:
      RDS cross-region read replica or regular encrypted snapshots.
      S3 cross-region replication for media assets.

c) Failover Execution:
      Promote read replica to primary database.
      Deploy or scale WordPress ASG in secondary region.
      Update DNS (Route 53) to point to secondary ALB.

RTO / RPO Expectations

   RTO (Recovery Time Objective): 30–60 minutes
   RPO (Recovery Point Objective):
       5 minutes with cross-region replication
       Up to 24 hours with snapshot-based recovery

Future Enhancements

Automate failover using Route 53 health checks.
Periodic DR drills and runbook validation.
Consider active-active multi-region for mission-critical workloads.