---
slug: direct-triggers
id: jk69lcdu7ik6
type: challenge
title: Testing Cloud Functions
teaser: Trigger your function with the command-line interface to test it's functionality.
notes:
- type: text
  contents: |-
    To support **quick iteration and debugging**, Cloud Functions provide a `gcloud functions call` command.

    This allows you to **directly invoke** a function to ensure it is behaving as expected.

    This causes the function to execute immediately, even though it may have been deployed to respond to a specific event.
tabs:
- title: Shell
  type: terminal
  hostname: shell
difficulty: basic
timelimit: 500
---
Use `help` and `hint`