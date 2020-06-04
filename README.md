# Github Create Branch

## Features
- Delete a branch 


## Options
```
jobs:
    <some job>:
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v2
            - name: delete-branch
              uses: et-lab/delete-branch@v1
              with: 
                branch: "" #branch to delete. if not provided defaults to branch that triggered action.
                github_token:  ${{ secrets.GITHUB_TOKEN }} (required)
                
```