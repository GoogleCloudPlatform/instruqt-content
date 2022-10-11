---
slug: call-authenticated-service
id: cs1v9xo6jp6u
type: challenge
title: Send Authenticated Requests
teaser: Make Sure You Can Connect
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 500
---
This is the final challenge to show you are mastered Cloud Run Part One!

 You now need to send **authenticated requests** to the protected service you deployed in the previous challenge.

 The URL of your protected service is in the environment variable **$SECRET_SERVICE_URL**

 Use ``gcloud auth print-identity-token`` to get your personal ID-token. Then add a ``Authorization: Bearer [TOKEN]`` HTTP header, and send a request with curl.
