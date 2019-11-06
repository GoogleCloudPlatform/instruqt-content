# Instruqt Arcade Machines for Google Cloud

## Base Container

The base container `gcr.io/instruqt-shadow/base` has the following features:

 * Adds support for `/root/.instruqt/.customenv` - Put environment variables here from `setup-shell` or create the file in `Dockerfile` and they will appear in the user's session.
 * Adds support for `/root/.instruqt/.customrc` - Put commands here from `setup-shell` or create the file in `Dockerfile` and they will run at the start of the user's session.
 * Adds `help` command - looks for `/root/.instruqt/help.txt` and prints the assignment. Also prints the image `/root/.instruqt/help.png` if it exists.
 * Adds `hint` command - looks for `/root/.instruqt/hint.txt` and prints a hint for moving onto the next challenge.
 * Adds `answer` command - prompts the user for an answer and puts their response in `/usr/local/bin/answer.txt` for checking in `check-shell`.
 * Prints `help` to the screen at the start of every challenge.
 * Adds `tiv` for printing images in the terminal via `tiv -256 /path/to/image.png`.

Use it by adding `gcr.io/instruqt-shadow/base` to your `Dockerfile`, or setting it as your image in `config.yaml`.
Modify it by editing the contents of `base-container/git diff `.

## Convensions

 * It's recommended that you put `set-workdir /home` in `setup-shell` so the user has a clean working directory plus relevant challenge files,
as opposed to `/root` which is the Instruqt default.

 * At the end of `fail-message`, add `Type "hint" if you get stuck.` and put a hint in `/root/.instruqt/hint.txt` so there's always a way to move forward.
