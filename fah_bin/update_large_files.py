#!/usr/bin/env python3
""" update_large_files: a utility for updating a reprository made of submodules
and large-files """
import subprocess
from multiprocessing import Process
import os


def synchronous_sub_proc_run( cmd_list, error_msg="", cwd=None):
    proc_run_info = subprocess.run(cmd_list, cwd=cwd)
    ret_code = proc_run_info.returncode
    if ret_code != 0 :
        raise RuntimeError("%s Exit code was %d"%(cmd_list, ret_code))


def find_matching_files(base_path, exact_match, strings):
    """ utility for filtering the string-container using @exact_match also, for
    simplicity, ensures that each matching file has the @base_path prepended """
    c0 = exact_match[0]
    return [ os.path.join(base_path, string) for string in strings if c0 == string[0] and exact_match == string ]


def update_git_submodules():
    """ calls git `submodule init` and `git submodule update`, throws if the
    commands fail """
    synchronous_sub_proc_run(["git", "submodule", "init"],
            error_msg=("Failed to [re]initialise submodules."
                       " Check your keys and access"))
    synchronous_sub_proc_run(["git", "submodule", "update"],
            error_msg="Failed to update submodules.")


def find_git_dirs():
    """ recursively find all .git dirs and files which map to .git dirs """
    ret = []
    for root, dirs, files in os.walk(".", topdown=False):
        ret.extend( find_matching_files(root, ".git", files) )
        ret.extend( find_matching_files(root, ".git", dirs) )
        # filter out the .git from the dirs as we don't need to recurse into
        # them
        dirs = [ d for d in dirs if ".git" not in d ]
    return ret


def is_submodule(git_dir):
    """ returns a boolean determining if the given dir is a submodule dir """
    assert os.path.exists(git_dir)
    if os.path.isdir(git_dir):
        return False
    # assume True otherwise
    return True


def get_real_gitdir(git_dir_or_file):
    """ resolves a .git file (used by submodules) into a dir when needed,
    otherwise returns the directory """
    git_dir = git_dir_or_file
    if not is_submodule(git_dir_or_file):
        # assume that if it's a dir called '.git' that it is, in fact, a
        # git-dir
        return git_dir
    # it's a file, try to resolve the real path
    git_file = git_dir_or_file
    base_dir = os.path.dirname(git_file)
    with open(git_file, 'r+') as git_submodule_file:
        git_dir = git_submodule_file.read().split("gitdir: ")[1].strip()
    git_dir = os.path.normpath(os.path.join(base_dir, git_dir))
    return git_dir


def get_hooks_dir(git_dir):
    """ simply joins the git_dir with the hooks path, almost a completely
    redundant func, but hey, separation of concerns and all that jazz """
    assert os.path.exists(git_dir)
    assert os.path.isdir(git_dir)
    git_hook_dir = os.path.join(git_dir, "hooks")
    return git_hook_dir


def is_lfs_repo(git_dir):
    """ determines, based on the hooks, whether the git repo is an lfs one or
    not """
    assert os.path.exists(git_dir)
    assert os.path.isdir(git_dir)
    hook_dir = get_hooks_dir(git_dir)
    for root, _, files in os.walk(hook_dir, topdown=False):
        for f in files:
            f = os.path.join(root,f)
            with open(f, 'r+') as hook_file:
                for line in hook_file.readlines():
                    if 'git-lfs' in line:
                        print("is git-lfs: %s" % git_dir)
                        return True
    #print("is NOT git-lfs: %s" % git_dir)
    return False


def info(title):
    """ print information about the sub-proccess """
    return
    print( title )
    print( 'module name:', __name__)
    if hasattr(os, 'getppid'):  # only available on Unix
        print('parent process:', os.getppid())
    print( 'process id:', os.getpid())


def sync_potential_git_lfs(git_dir_or_file):
    """ Marshals the bits of the update that can be split up """
    info(git_dir_or_file) # first do some info printing
    git_dir = get_real_gitdir(git_dir_or_file)
    assert os.path.exists(git_dir)
    assert os.path.isdir(git_dir)

    if not is_lfs_repo(git_dir):
        return # don't do anything for non-lfs repo

    # the git command needs to be called from inside the correct directory
    working_dir = os.path.dirname( git_dir_or_file ) # the path where we need to do the install and sync from
    print("working in: '%s'"%working_dir)

    # [re]do the install
    synchronous_sub_proc_run(["git", "lfs", "install"],
            error_msg="Failed to [re]install lfs. Check your ssh keys.",
            cwd=working_dir)

    # get the latest version
    synchronous_sub_proc_run(["git", "lfs", "pull"],
            error_msg="Pull failed for %s."%git_dir_or_file,
            cwd=working_dir)


if __name__ == '__main__':
    info('main line')
    # synchronous bits
    update_git_submodules()
    git_dirs = find_git_dirs()

    # asynchronous bit
    # Things that we can parallelise because they take so long
    procs = {}
    if False:
        for git_dir in git_dirs :
            # NOTE: Because this changes the CWD this needs to be a sub-proc rather
            #       than a thread, a big python gotcha
            p = Process(target=sync_potential_git_lfs, args=(git_dir,))
            p.start()
            procs[git_dir] = p
        for git_dir, p in procs.items():
            # block until all procs are complete
            print("Waiting for %s, "%git_dir, end='')
            p.join()
            print("done")
    else:
        for git_dir in git_dirs :
            sync_potential_git_lfs(git_dir)
