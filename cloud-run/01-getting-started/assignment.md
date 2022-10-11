---
slug: getting-started
id: ytklsbobnhnb
type: challenge
title: Getting Started with Cloud Run
teaser: Understanding an example application
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 500
---
Cloud Run will run any container with an HTTP server as a service: you push your container image and get a URL back.

 If it speaks HTTP, Cloud Run will serve it, even a **shell-based web server**.

 First, take a look at the current directory. There is a ``Dockerfile`` and a ``response.sh``.

 The Dockerfile contains a list of commands to build a container image.

 The response.sh file is executed for every incoming HTTP request. It returns an HTTP response.

 Your task is to read both files and to execute ``response.sh``.