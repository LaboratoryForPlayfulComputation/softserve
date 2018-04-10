# Stub for a python program that should interactively build and import
# a static instance of Makecode into the elixir app
import os
import argparse
import subprocess

parser = argparse.ArgumentParser(description='Builds a static Makecode instance and drops it into the Elixir static assets folder')

parser.add_argument('--src', 
                    dest='src', 
                    action='store',
                    help='Makecode directory (NOT the built directory)',
                    default='../pxt-sample/')
                    

parser.add_argument('--dest', 
                    dest='dest', 
                    action='store',
                    help='Destination for static assets',
                    default='./priv/static/')
                    

args = parser.parse_args()
confirm = input("copy makecode build from " + args.src + " to " + args.dest + " ? (y/n) ")

if ((confirm == 'y') or (confirm == 'Y')):
    if (os.path.exists(args.src)):
        print('found ' + args.src)
        os.chdir(args.src)
        print('pwd: ' + os.getcwd())
        print('building...')
        makecodeBuildProc = subprocess.run(['pxt', 'staticpkg'])

        if (makecodeBuildProc.returncode != 0):
            print('Makecode build failed with exit code: ' + makecodeBuildProc.returncode)
        else:
            print('Makecode build successful')
            copySrc = './built/packaged/'
            copyDst = '../softserve' + args.dest[1:]
            if (os.path.exists(copySrc) and (os.path.exists(copyDst))):
                copyProc = subprocess.run(['cp', '-R', copySrc, copyDst])
                if (copyProc.returncode != 0):
                    print('Copy build failed with exit code:' + copyProc.returncode)
                else:
                    print('****** Makecode static build successfully copied from ' + os.path.abspath(copySrc) +  ' to ' + os.path.abspath(copyDst) + ' ******')
            
            elif (os.path.exists(copySrc) == False):
                print('problem with the source while copying')
            elif (os.path.exists(copyDst) == False):
                print('problem with the destination while copying')
            else:
                print('unknown error while copying')
    else:
        print('path not found to Makecode source!')
else:
    print('aborted')





