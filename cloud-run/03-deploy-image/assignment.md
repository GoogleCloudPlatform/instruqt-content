---
slug: deploy-image
id: ye2fj00fvvwc
type: challenge
title: Deploying a Container
teaser: Deploy your container to Cloud Run
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 600
---
The next step is to deploy the image to Cloud Run using ``gcloud run deploy``.

 The tag for the image you just built is in the environment variable ``$IMAGE_TAG``

 1. Give the service you create public access by allowing unauthenticated invocations.
 2. Prove that your service works by calling the URL.
