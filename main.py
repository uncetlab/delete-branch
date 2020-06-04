import os
import sys

branch = os.getenv("INPUT_BRANCH") if not os.getenv("INPUT_BRANCH") is None else  os.getenv("GITHUB_REF")
print(branch)

os.environ['BRANCH'] = branch
os.system("/deletebranch.sh")


