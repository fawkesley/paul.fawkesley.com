---
title: Packaging Python for Windows with Pyinstaller and Wine
permalink: /packaging-python-for-windows-pyinstaller-wine/
category: python

---
If you've ever had to deploy Python on Windows you'll know it's a headache. If, like me, you develop in Linux, it's a positive migraine. Hopefully I can help...

I've used Pyinstaller v1.5 in the past quite a bit with some success but doing so in Wine on Linux has always been a bit flaky. Since Pyinstaller-2.0 came out a while back I felt it was only right to revisit and see if I could make a more robust setup.

Today I knocked up some scripts to help create and manage a dedicated Wine "build" environment and run Pyinstaller inside Wine to create a "frozen" standalone Windows executable file from your Python source.

Visit the <a title="GitHub" href="https://github.com/paulfurley/python-windows-packager" target="_blank">project on GitHub</a> or clone the repo and get involved. On the first run it'll give you instructions on setting up your dedicated wine environment, but you won't need to do this again.

<pre>$ git clone https://github.com/paulfurley/python-windows-packager
$ ./package.sh /path/to/my/main.py MyProject</pre>

... and \*fingers crossed\* out pops /tmp/MyProject.exe

Feel free to have a play, fork the code, let me know what you think.

Enjoy!