---
slug: service
id: brhm7nqdzd4u
type: challenge
title: Services
teaser: Exposing your microservice to the world
notes:
- type: text
  contents: |-
    While Deployments run your containers, **Services** tie them all together. Services act a service discovery and load balancing endpoints for your microservices.
    This allows you to run multiple copies of your app without worrying about how other microservices in the cluster will find them.
- type: text
  contents: Services also let you create Network Load Balancers on GCP, allowing you
    to expose your microservices directly to the world behind an automatically configured
    and scalable load balancer.
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 600
---
Use `help` and `hint`