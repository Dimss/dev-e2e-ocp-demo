NAMESPACE := kbit

deploy-backend:
	pipenv run ansible-playbook site.yml --tags backend --extra-vars "namespace=${NAMESPACE}"

deploy-frontend:
	pipenv run ansible-playbook site.yml --tags frontend --extra-vars "namespace=${NAMESPACE}"

remove-frontend:
	pipenv run ansible-playbook site.yml --tags frontend --extra-vars "namespace=${NAMESPACE} state=absent"

s2i-build:
	pipenv run ansible-playbook site.yml --tags s2ibuild --extra-vars "namespace=${NAMESPACE}"

docker-build:
	pipenv run ansible-playbook site.yml --tags dockerBuild --extra-vars "namespace=${NAMESPACE}"

s2i-build-trigger:
	pipenv run ansible-playbook site.yml --tags s2ibuild-trigger --extra-vars "namespace=${NAMESPACE}"

clean-completed:
	 oc get pods | grep -i completed | cut -f1 -d " " | xargs oc delete pod

remove-all:
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE} state=absent"
