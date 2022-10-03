---
slug: configmaps-secrets
id: 9yslerdv9ht0
type: challenge
title: ConfigMaps and Secrets
teaser: Harness the power of distributed environment variables
notes:
- type: text
  contents: 'Running your containers is just the tip of the iceberg when it comes
    to Kubernetes. Configuring and managing your app is equally important. Kubernetes
    provides two powerful config management primitives out of the box: **ConfigMaps**
    and **Secrets**'
- type: text
  contents: Kubernetes **ConfigMaps** allow you to decouple configuration artifacts
    from image content to keep containerized applications portable. ConfigMaps allow
    environment specific data and files to be injected into your containers at runtime,
    allowing containers to be reused more easily.
- type: text
  contents: Kubernetes **Secrets** are similar, except they are for storing confidential
    information.
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 600
---
Use `help` and `hint`