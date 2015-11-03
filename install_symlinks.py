#!/usr/bin/python

from __future__ import print_function

import os
import sys
import logging

log = logging.getLogger(__name__)
ignoredfiles = set((".git", ".gitignore", os.path.basename(__file__)))


def installfile(file, installdir):
    try:
        os.symlink(os.path.relpath(file, start=installdir),
               os.path.join(installdir, file))
    except:
        log.exception("Problem creating symbolic link")

def do_install(installdir=os.path.expanduser("~"), dryrun=True):
    if not os.path.isdir(installdir):
        log.error("Cannot install to {}. It is not a directory".format(installdir))
        raise RuntimeError("installdir is not directory")

    installs = []
    installed = []
    conflicts = []
    for file in os.listdir('.'):
        if file.startswith("."):
            if file in ignoredfiles:
                continue
            try:
                if os.path.samefile(file, os.path.join(installdir, file)):
                    installed.append(file)
                    log.info("{} is already installed".format(file))
                else:
                    log.warning("Conflicting file {}".format(file))
                    conflicts.append(file)
            except OSError:  # FileNotFoundError: OSError instead for python 2 compatibility
                if not dryrun:
                    installfile(file, installdir)
                installs.append(file)
                print("{} installed".format(file))

    return dict(installs=installs, installed=installed, conflicts=conflicts)


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    defaultinstall = os.path.expanduser("~")
    parser.add_argument("installpath",
                        help="Path to install symbolic links (default:{})".format(defaultinstall),
                        default=defaultinstall, nargs='?', type=os.path.expanduser)
    parser.add_argument("--log", help="log level", type=int)
    parser.add_argument("-n", "--dryrun", help="Perform dry run, don't actually do anything",
                        action="store_false")  # This setting defaults the value to true unless on command line.
    args = parser.parse_args()

    logging.basicConfig(level=args.log)
    try:
        results = do_install(installdir=args.installpath, dryrun=args.dryrun)
    except:
        errors = True
    else:
        errors = False

    if errors or results['conflicts']:
        sys.exit(1)
