# Instruqt Content for Google Cloud NEXT

## Base Container

The base container `gcr.io/instruqt-shadow/base` has the following features:

 * Adds support for `/root/.customenv`. put environment variables here in your `setup-shell` script and they will appear in the user's session.
 * `help` command - looks for `/home/help.txt` and prints the assignment. Also prints the image `/root/help.png` if it exists.
 * `hint` command - looks for `/home/hint.txt` and prints a hint for moving onto the next challenge. 
 * `answer` command - prompts the user for an answer and puts their response in `/usr/local/bin/answer.txt` for checking in `check-shell`.
 * Prints `help` to the screen at the start of every assignment.
 * Adds `tiv` for printing images in the terminal via `tiv -256 /path/to/image.png`.

Use it by adding `gcr.io/instruqt-shadow/base` to your `Dockerfile`, or setting it as your image in `config.yaml`.

Modify it by editing the contents of `base-container/`.
