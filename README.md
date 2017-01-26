# Sample IBMi Application

Arcad/GitHub samples project to demonstrate IBMi/Arcad and GitHub integration and workflow.

Collaborators:
 - Michel (Arcad) 
 - Marc (Arcad)
 - Vitor (GitHub)

## Demo Flow

1. Open [githubtraining.atlassian.net](https://githubtraining.atlassian.net/) and visit the [IBMi Project Board](https://githubtraining.atlassian.net/secure/RapidBoard.jspa?rapidView=32&view=detail&selectedIssue=IBMI-6)
2. Start the [GitHub Flow locally](https://guides.github.com/introduction/flow/) 
2. Start working on on `sample-ibmi-app/sample-ibm-app/QDDSSRC/HSPCOMP.PF`
3. Add a new Field `A            WCTYCD    10A         COLHDG('Country Code')`
4. Start a conversation in a pull request and initiate a review process
5. Merge and initiate deploy workflow

Finished result should be:

```
     A            WCTYCD    R               COLHDG('Country Code')
     A                                      REFFLD(A1)
```