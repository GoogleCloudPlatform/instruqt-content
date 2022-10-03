---
slug: deployment
id: yuguvnps4uoy
type: challenge
title: Deployments
teaser: Running your microservice
notes:
- type: text
  contents: One of the fundamental building blocks of Kubernetes is the **Pod**. Pods
    are a group of one or more containers that are scheduled together, for example
    a web server and a log collector.
- type: text
  contents: Pods are scheduled onto the cluster with a scheduler. The most common
    scheduler is a **Deployment**. Deployments let you run, scale, and update your
    Pods in a declarative fashion.
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 500
---
Use `help` and `hint`