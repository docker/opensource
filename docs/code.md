<!--[metadata]>
+++
title = "Quickstart contribution"
description = "Contribute code"
keywords = ["governance, board, members, profiles"]
[menu.main]
parent="mn_oss_contrib"
weight=-3
+++
<![end-metadata]-->

# Quickstart code or doc contribution

If you'd like to improve the code of any of Docker's projects, we would love to
have your contributions. All of our projects' code [repositories are on GitHub](https://github.com/docker).

If you want to contribute to the `docker/docker` repository you should be
familiar with or a invested in learning Go or the Markdown language.  If you
know other languages, investigate our other repositories&mdash;not all of them
run on Go.

# Code contribution workflow

Below is the general workflow for contributing Docker code or documentation.
If you are an experienced open source contributor you may be familiar with this
workflow. If you are new or just need reminders, the steps below link to more
detailed documentation in Docker's project contributors guide.

1. [Get the software](project/software-required.md) you need.

	This explains how to install a couple of tools used in our development
	environment.  What you need (or don't need) might surprise you.

2. [Configure Git and fork the repo](project/set-up-git.md).

	Your Git configuration can make it easier for you to contribute.
	Configuration is especially key if are new to contributing or to Docker.

3. [Learn to work with the Docker development container](project/set-up-dev-env.md).

	Docker developers run `docker` in `docker`.  If you are a geek,
	this is a pretty cool experience.

4. [Claim an issue](workflow/find-an-issue.md) to work on.

	We created a filter listing 
	[all open and unclaimed issues](https://goo.gl/Hsp2mk) for Docker.

5. [Work on the issue](workflow/work-issue.md).

	If you change or add code or docs to a project, you should test your changes
	as you work. This page explains 
	[how to	test in our development environment](project/test-and-docs.md).  

	Also, remember to always **sign your commits** as you work! To sign your
	commits, include the `-s` flag in your commit like this:

		$ git commit -s -m "Add commit with signature example"

	If you don't sign [Gordon](https://twitter.com/gordontheturtle) will get you!

6. [Create a pull request](workflow/create-pr.md).

	If you make a change to fix an issue, add reference to the issue in the pull
	request. Here is an example of a perfect pull request with a good description,
	issue reference, and signature in the commit:

	![Sign commits and issues](images/bonus.png)

	We have also have checklist that describes [what each pull request
	needs](#what-is-the-pre-pull-request-checklist).


7. [Participate in the pull request review](workflow/review-pr.md) 
till a successful merge.
