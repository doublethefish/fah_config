#!/usr/bin/python

import logging
import os
import subprocess
import sys

import argparse


def die(msg=None):
    """
    Cleanly exits the program with an error message. Erases all remaining
    temporary files.
    """
    if msg:
        print msg

    sys.exit(1)


def execute(command,
            env=None,
            split_lines=False,
            ignore_errors=False,
            extra_ignore_errors=(),
            translate_newlines=True,
            with_errors=True,
            none_on_ignored_error=False):
    """
    Utility function to execute a command and return the output.
    """
    if isinstance(command, list):
        logging.debug('Running: ' + subprocess.list2cmdline(command))
    else:
        logging.debug('Running: ' + command)

    if env:
        env.update(os.environ)
    else:
        env = os.environ.copy()

    env['LC_ALL'] = 'en_US.UTF-8'
    env['LANGUAGE'] = 'en_US.UTF-8'

    if with_errors:
        errors_output = subprocess.STDOUT
    else:
        errors_output = subprocess.PIPE

    if sys.platform.startswith('win'):
        p = subprocess.Popen(command,
                             stdin=subprocess.PIPE,
                             stdout=subprocess.PIPE,
                             stderr=errors_output,
                             shell=False,
                             universal_newlines=translate_newlines,
                             env=env)
    else:
        p = subprocess.Popen(command,
                             stdin=subprocess.PIPE,
                             stdout=subprocess.PIPE,
                             stderr=errors_output,
                             shell=False,
                             close_fds=True,
                             universal_newlines=translate_newlines,
                             env=env)
    if split_lines:
        data = p.stdout.readlines()
    else:
        data = p.stdout.read()

    rc = p.wait()

    if rc and not ignore_errors and rc not in extra_ignore_errors:
        die('Failed to execute command: %s\n%s' % (command, data))
    elif rc:
        logging.debug('Command exited with rc %s: %s\n%s---'
                      % (rc, command, data))

    if rc and none_on_ignored_error:
        return None

    return data

# Sort out command line arguments
#
parser = argparse.ArgumentParser()
parser.add_argument('--hash', nargs='?', const='', default='', help="hash of commit that you wish to submit for review")
parser.add_argument('--all', help="submit reviews for all commits since merge-base of current branch", action="store_true")
args = parser.parse_known_args()

if not args[0].all and len(args[0].hash) == 0:
    # no hash and not processing all commits
    die('Error: Must specify --hash or --all')

if args[0].all:
    # Get the various bits of GIT information we need
    #
    upstream_branch = 'remotes/git-svn' #execute(['git', 'rev-parse', '--abbrev-ref', 'HEAD']).strip()
    #print upstream_branch
    head_ref = execute(['git', 'symbolic-ref', '-q', 'HEAD']).strip()
    #print head_ref
    merge_base = execute(['git', 'merge-base', upstream_branch, head_ref]).strip()
    #print merge_base
    commit_hashes = execute(['git', 'log', '--pretty=format:%H', '--reverse', merge_base + '..']).strip()
    #print commit_hashes
    hashes_to_diff = []
    hashes_to_diff.append(merge_base)
    hashes_to_diff = hashes_to_diff + commit_hashes.split()
    #print hashes_to_diff

    print 'Submitting reviews for all commits since merge-base with ' + upstream_branch + '(' + merge_base + ')'
    if len(args[0].hash) != 0:
        print 'Ignoring hash ' + args[0].hash + ' specified on command line'

    # loop over pairs of hashes and submit the diffs from them
    for i in range( len(hashes_to_diff) - 1):
        print 'Review of', hashes_to_diff[i], 'to', hashes_to_diff[(i+1)]
        cmd = ['rbt', 'post', '-g', '--branch', upstream_branch, # + ' (' + hashes_to_diff[(i+1)] + ')',
                          '--revision-range', hashes_to_diff[i] + ':' + hashes_to_diff[(i+1)] ] + args[1]
        print " ".join(cmd)
        review = execute( cmd )
        print review
else:
    # This may not be a full hash. Could be HEAD~2, a shortened hash or something else
    hash = args[0].hash

    # Get the various bits of GIT information we need
    #
    # get the commit hashes for the two previous commits
    commit_hashes = execute(['git', 'log', '--pretty=format:%H', '--reverse', '-2', hash]).strip()
    #print commit_hashes
    hashes_to_diff = commit_hashes.split()
    #print hashes_to_diff

    branches = execute(['git', 'branch', '-a', '--no-color', '--contains', hash]).strip()
    branches_list = branches.split('\n')

    #print branches_list

    # just use the first branch unless we are currently on a branch
    branch = branches_list[0]
    for i in range(len(branches_list)):
        if branches_list[i].strip()[0] == '*':
            branch = branches_list[i].strip(' *')
    #print branch

    print 'Review of', hashes_to_diff[0], 'to', hashes_to_diff[1]
    cmd = ['rbt', 'post', '-I', hashes_to_diff[1], '--parent=%s'%hashes_to_diff[0] ] + args[1]
    print " ".join( cmd )
    review = execute( cmd )
    print review

