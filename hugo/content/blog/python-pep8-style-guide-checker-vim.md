---
date: "2013-05-01"
title: Python PEP8 Style Guide Checker for Vim
permalink: /python-pep8-style-guide-checker-vim/
category: python
---
## Using Pathogen, Syntastic and flake8

The <a title="PEP8 python style guide" href="http://www.python.org/dev/peps/pep-0008/" target="_blank">PEP8</a> style guide for Python is great - if you aren't already using it, I strongly recommend it, especially if you're working with others.

This post is a super quick guide to integrating a PEP8 checker with Vim on Ubuntu 12.04LTS. Every time you save, PEP8 recommendations will be shown in the leftmost column of Vim. We'll be using <a title="Pathogen vim package manager" href="https://github.com/tpope/vim-pathogen" target="_blank">Pathogen</a>, <a title="Syntastic vim syntax checker" href="https://github.com/scrooloose/syntastic" target="_blank">Syntastic</a> and <a title="Flake8" href="https://pypi.python.org/pypi/flake8" target="_blank">Flake8</a> (which itself wraps <a title="pep8 checker" href="https://pypi.python.org/pypi/pep8" target="_blank">pep8</a>, <a title="pyflakes" href="https://pypi.python.org/pypi/pyflakes" target="_blank">pyflakes</a> and <a title="mccabe script" href="https://pypi.python.org/pypi/mccabe" target="_blank">mccabe</a>).

If you aren't already using it, install Pathogen, a Vim package manager:

`<br />
$ mkdir -p ~/.vim/autoload ~/.vim/bundle<br />
$ curl 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim' > ~/.vim/autoload/pathogen.vim<br />
`

Make pathogen run when starting up vim.
`<br />
$ echo 'call pathogen#infect()' >> ~/.vimrc<br />
`

If you don't already have the following lines in your ~/.vimrc file, you'll need to add these too:
`<br />
syntax on<br />
filetype plugin indent on<br />
`

Test that pathogen is installed (inside vim). If you get an error it's probably because you've omitted `'call pathogen#infect()'`
`<br />
:Helptags<br />
`

Install latest Syntastic syntax checker.
`<br />
$ cd ~/.vim/bundle<br />
$ git clone https://github.com/scrooloose/syntastic.git<br />
`

Test syntastic (inside vim)
`<br />
:h syntastic<br />
`

Install flake8 (pep8, Pyflakes and Ned Batchelder's McCabe script)
`<br />
$ sudo pip install flake8     # install globally<br />
`

` $ pip install --user flake8  # install locally<br />
`

That's it! When you next save a Python file, you'll be delighted by what you see...

**Any thoughts? Can you recommend an automatic PEP8-ifier?**

**Leave a comment below.**
