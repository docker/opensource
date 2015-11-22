<!--[metadata]>
+++
title = "Testing contributions"
description = "Testing contributions"
keywords = ["test, source, contributions, Docker"]
[menu.main]
parent="smn_ways"
+++
<![end-metadata]-->

# Testing contributions

Testing is about software quality, performance, reliability, or product
usability. We develop and test Docker software before we release but we are
human. So, we make mistakes, we get forgetful, or we just don't have enough
time to do everything.

Choose to contribute testing if you want to improve Docker software and
processes. Testing is a good choice for contributors that have experience
software testing, usability testing, or who are otherwise great at spotting
problems.

# What can you contribute to testing?

* Write a blog about 
[how your company uses Docker's test infrastructure](https://www.appneta.com/blog/automated-testing-with-docker/).  
* Take [an online usability test](http://ows.io/tj/w88v3siv) or create a usability test about Docker.
* Test one of [Docker's official images](https://github.com/docker-library/official-images/issues)
* Test the Docker documentation


# Test the Docker documentation

Testing documentation is relatively easy:

## Step 1.  Find a page in [Docker's documentation](https://docs.docker.com/) that contains a procedure or example you want to test.

You should choose something that _should work_ on your machine. For example,
[creating a base image](https://docs.docker.com/articles/baseimages) is something anyone with Docker can do. 
While [changing volume directories in Kitematic](https://kitematic.com/docs/managing-volumes/) 
requires a Mac and Docker's Kitematic installed.

## Step 2.  Try and follow the procedure or recreate the example.

What to look for:

 * Are the steps clearly laid out and identifiable?
 * Are the steps in the right order?
 * Did you get the results the procedure or example said you would?

## Step 3.  If you couldn't complete the procedure or example, 
file [an issue in the Docker repo](https://github.com/docker/docker/issues/new).

# Test code in the Docker

If you are interested in writing or fixing test code for the Docker project, learn  about 
[our test infrastructure](https://docs.docker.com/project/test-and-docs/).

View [our open test issues](https://goo.gl/EkyABb) in Docker for something to work on. Or, create one of your own.
