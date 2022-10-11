---
slug: build-image
id: tgmu3ip55rdv
type: challenge
title: Building a Container Image
teaser: Build a container image with Cloud Build
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 500
---
To start the service on **Cloud Run**, you need a container image.

 We want to build an application from the Dockerfile in your local source, but we don't have docker installed locally. We can build it in the cloud with **Cloud Build**.

 Cloud Build will build any directory with a ``Dockerfile``, when you add the -t option with an image name.

 Your task: using ``gcloud builds submit``, push a build to Cloud Build and tag the container image with the name contained in the environment variable ``$IMAGE_TAG``