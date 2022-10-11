---
slug: authenticated-service
id: o71fmzqicudr
type: challenge
title: Protect Your Cloud Run Service
teaser: Allow Only Authenticated Traffic
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 500
---
You can also protect Cloud Run services from public access. This is what you need to do:

 1. Deploy the same image (``$IMAGE_TAG``) as a second service with a different name. This time, do not allow unauthenticated access.
 2. Send a request to the service with ``curl``, to show you don't have permission to call it.
