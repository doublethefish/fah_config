#!/usr/bin/env python2
import subprocess
import sys
import pickle

def get_cmd_ret_lines(cmd):
    #print " ".join(cmd)
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    out, err = p.communicate()
    output = "\n".join((str(out), str(err)))
    lines = output.split("\n")
    return lines


def get_commit_msg(sha):
    cmd = ["git",
            "show",
            sha
            ]
    cmd = ["git", "log", "-n", "1", "--pretty=format:\%s", sha ]
    lines = get_cmd_ret_lines(cmd)
    return lines


def process_commits(base_branch):
    cmd = ["git",
            "rev-list",
            "%s..HEAD"%base_branch
            ]
    lines = get_cmd_ret_lines(cmd)
    for line in lines:
        sha = line.strip()
        msg = get_commit_msg(sha)
        print "fah: ", sha, msg[0]

known_tags = ( "NodeDescription", "plugs", "types", "kernels" )

#process_commits("origin/fix/RTCOR-62-Fix_PluginRegistry_memory-leak_in_ExecutionEngine_unit-tests")

def get_tag(line):
    for idx, tag in enumerate(known_tags):
        if "[%s]" % tag in line:
            return idx+1, tag
    return -1, None


def get_rebase_todo(file_path):
    print "fah: ", file_path
    with open(file_path, 'r') as f:
        lines = f.read().split("\n")

    lines = [line for line in lines if line and line[0] != '#']

    orig = lines
    try:
        attempted = pickle.load( open( "/tmp/save.p", "rb" ) )
        print "fah: ", "Loaded attempts from file"
        #for attempt in attempted:
        #    print attempt
    except IOError:
        attempted = [orig, ]
        print "fah: ", "Starting from scratch"
    last_working = orig
    prev = ('', -1, '')
    new_attempt = None
    for idx, line in enumerate(lines):
        priority, tag = get_tag(line)
        data = tag, priority, line
        print "PASS1", idx, data
        if priority == prev[1]:
            #print "fah: ", "same prio"
            pass
        elif priority > prev[1]:
            #print "fah: ", "prev has prio"
            pass
        elif priority < prev[1]:
            cand_attempt = lines[:]
            cand_attempt[idx], cand_attempt[idx-1] = cand_attempt[idx-1], cand_attempt[idx]
            if cand_attempt not in attempted:
                print "fah: ", "this has prio over prev"
                print "fah: ", "swapping %d with %d" % (idx, idx -1)
                new_attempt = cand_attempt
                print "not found"
                break
            else:
                print "exists 1"
        else:
            raise RuntimeError("none of the above : %s" % data)
        prev = data

    # we've found a new candidate
    if new_attempt:
        print "fah: Saving attempts to file"
        attempted.append(new_attempt[:])
        pickle.dump( attempted, open( "/tmp/save.p", "wb" ) )
        with open(file_path, "w+") as f:
            f.write("\n".join(new_attempt))
        return

    raise RuntimeError("no cand found")

    for idx, line in enumerate(lines):
        priority, tag = get_tag(line)
        data = tag, priority, line
        print "PASS2", idx, data
        if priority == prev[1]:
            cand_attempt = lines[:]
            cand_attempt[idx], cand_attempt[idx-1] = cand_attempt[idx-1], cand_attempt[idx]
            if cand_attempt not in attempted:
                print "fah: ", "same prio"
                print "fah: ", "swapping %d with %d" % (idx, idx -1)
                new_attempt = cand_attempt
                print "not found"
                break
            else:
                print "exists 2"
            pass
        elif priority > prev[1]:
            #print "fah: ", "prev has prio"
            pass
        elif priority < prev[1]:
            #print "fah: ", "this has prio over prev"
            pass
        else:
            raise RuntimeError("none of the above : %s" % data)
        prev = data

    # we've found a new candidate
    if new_attempt:
        print "fah: Saving attempts to file"
        attempted.append(new_attempt)
        pickle.dump( attempted, open( "/tmp/save.p", "wb" ) )
        with open(file_path, "w+") as f:
            f.write("\n".join(new_attempt))
        return

    raise RuntimeError("no cand found")



get_rebase_todo(sys.argv[1])

