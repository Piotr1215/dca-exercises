# 1. Enable persisting data after pod is destroyed

# Create a file inside a mounted folder of the pod
k exec -it testpod -- sh
cd /mnt/azure/
echo "Will I still be here for new pod?" > testfile.txt
cat testfile.txt

# Remove the pod
k delete pod testpod

# Create pod again
kubectl apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/storage-pv-pvc/3-create-pod.yaml

# Check if the file still exist in the mounted directory
k exec -it testpod -- cat /mnt/azure/testfile.txt

# 2. Decouples storage provisioning activity from its consumption

# Increase persistent volume capacity
k edit pv azurefile

# Change storage to 10Gi, exit and save vim (:wq). Check pv
k describe pv azurefile

# Make sure that file is still there
k exec -it testpod -- cat /mnt/azure/testfile.txt

# 3. Enable data sharing between pods

# Create another pod bound to the same persistent volume
k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/storage-pv-pvc/4-create-pod2.yaml

# Open new Azure Cloud session and exec into testpod
k exec -it testpod -- sh
cd /mnt/azure/
ls

# Watch for file changes
watch -n1 'ls ./*'

# Swap to another shell and create file in testpod2
k exec -it testpod2 -- touch /mnt/azure/new_testfile.txt

