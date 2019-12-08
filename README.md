# Dev & Ops OCP Demo

## CI 
### Demo 1 - S2I build 
```bash
# Create build objects 
make s2i-build
# Start the build either from cli or from ui
oc start-build -F ui
``` 

### Demo 2 - Custom build 
```bash
# Create build objects 
make s2i-build
# Start the build either from cli or from ui
oc start-build -F ui
``` 

### Demo 2 - S2I build with trigger 
```bash
# Create build objects 
make s2i-build
# Start the build either from cli or from ui
oc start-build -F ui
``` 


## CD

### Demo 3 - Simple deploy  
```bash
# Deploy backend 
make deploy-backend
# Deploy frontend
make deploy-frontend
``` 

### Demo 4 - build and deploy with trigger 
```bash
# remove frontend if it's exists
make remove-frontend

# Create S2i build with webhook trigger
make s2i-build-trigger

# edit code and commit changed, the build should start automatically 
# deploy frontend 
make deploy-frontend

# tag latest image with commit id  
COMMIT_ID=$(oc get istag kbit-ui:latest  -o json  | jq -r ".image.dockerImageMetadata.Config.Labels.\"io.openshift.build.commit.id\"" | cut -c1-7)
oc tag kbit-ui:latest kbit-ui:${COMMIT_ID}

# edit code again to trigger new build, and retag again
COMMIT_ID=$(oc get istag kbit-ui:latest  -o json  | jq -r ".image.dockerImageMetadata.Config.Labels.\"io.openshift.build.commit.id\"" | cut -c1-7)
oc tag kbit-ui:latest kbit-ui:${COMMIT_ID} 

# Update latest tag
oc tag kbit-ui:commit-id kbit-ui:latest

``` 