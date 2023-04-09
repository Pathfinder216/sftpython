import sys
import os

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
# sys.path.insert(0, os.path.abspath('.'))

sys.path.insert(0, os.path.abspath(".."))

import sftpython

# -- Project information -----------------------------------------------------
project = "sftpython"
copyright = "2023, Ben Green"
author = "Ben Green"
release = sftpython.__version__

# -- General configuration ---------------------------------------------------
extensions = ["sphinx.ext.autodoc", "sphinx.ext.napoleon", "myst_parser"]
myst_heading_anchors = 3


# -- Options for HTML output -------------------------------------------------
html_theme = "alabaster"
