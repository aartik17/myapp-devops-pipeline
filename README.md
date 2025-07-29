
# **devops-case-study-2 – CI/CD Pipeline with Terraform, Ansible, Jenkins, Docker, GitHub, and AWS**

##  Project Overview

This project demonstrates a complete DevOps workflow that automates infrastructure provisioning, application configuration, and CI/CD setup using:

* **Terraform** – for Infrastructure as Code (IaC)
* **Ansible** – for configuring EC2 instances and deploying the app
* **Jenkins** – for automating the CI/CD pipeline
* **Git & GitHub** – for version control
* **Docker** – for containerizing the application
* **AWS EC2** – as the cloud infrastructure for Jenkins and app hosting


##  Tools & Technologies

| Tool      | Purpose                                    |
| --------- | ------------------------------------------ |
| Terraform | Provisioning AWS EC2 instance              |
| Ansible   | Installing Docker, deploying app           |
| Jenkins   | CI/CD automation pipeline                  |
| Docker    | Containerizing the Node.js app             |
| Git       | Version control                            |
| GitHub    | Hosting source code                        |
| AWS EC2   | Running Jenkins and application containers |

---

##  Repository Structure

```
myapp-devops-pipeline/
├── Dockerfile
├── Jenkinsfile
├── ansible/
│   ├── deploy.yml
│   └── hosts.ini
├── infra/
│   ├── main.tf
│   ├── output.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── scripts/
│   └── build_and_push.sh
├── src/
│   └── index.js
└── README.md
```

---

##  How to Run the Project

### Step 1: Clone the Repository

```bash
git clone https://github.com/aartik17/myapp-devops-pipeline.git
cd myapp-devops-pipeline
git checkout -b develop
```

>  On GitHub: Go to Settings → Branches → Branch protection rules → Add `main` → Enable pull request requirements.

---

###  Step 2: Dockerization

1. Create `src/index.js` with a basic Node.js server (Hello World).

2. Create `Dockerfile`:

```dockerfile
FROM node:18
WORKDIR /app
COPY src/ /app
RUN npm install
EXPOSE 3000
CMD ["node", "index.js"]
```

3. Create the Docker build & push script in `scripts/build_and_push.sh`:

```bash
#!/bin/bash
IMAGE_NAME=aartik17/myapp
docker build -t $IMAGE_NAME:$GIT_COMMIT .
docker push $IMAGE_NAME:$GIT_COMMIT
```

4. Run the script:

```bash
export GIT_COMMIT=$(git rev-parse --short HEAD)
chmod +x scripts/build_and_push.sh
./scripts/build_and_push.sh
```

5. Push your changes to GitHub:

```bash
git add .
git commit -m "Add Node.js app and Dockerfile"
git push origin develop
```

>  Go to GitHub → Create a Pull Request → Merge into `main`.

---

###  Step 3: Provision Infrastructure with Terraform

```bash
cd infra
terraform init
terraform plan
terraform apply -auto-approve
```

**What gets provisioned:**

* EC2 instance (Ubuntu 22.04)
* Custom VPC & public subnet
* Elastic IP (e.g., `52.66.155.96')
* Security group allowing SSH (22) and HTTP (80)

---

###  Step 4: Deploy App Using Ansible

1. Ensure `.gitignore` contains:

```
terraform.tfstate
terraform.tfstate.backup
```

2. Run the playbook:

```
bash
ansible-playbook -i ansible/hosts.ini ansible/deploy.yml
```

---

###  Step 5: Jenkins Setup

1. Access Jenkins: `http://52.66.155.96:8080`
2. Unlock Jenkins, install suggested plugins
3. Create a **New Pipeline Job** → use the `Jenkinsfile` from the repo

---

###  Step 6: Jenkins GitHub Integration

**PART 1: Configure Pipeline Job**

* Open Jenkins → Job → Configure
* Change branch to: `*/develop`
* Enable trigger:  GitHub hook trigger for GITScm polling

**PART 2: Add GitHub Webhook**

* GitHub → Repo → Settings → Webhooks → Add

  * **Payload URL**: `http://<JENKINS_PUBLIC_IP>:8080/github-webhook/`
  * **Content type**: `application/json`
  * **Events**: Just the push event

---

### Step 7: Test the CI/CD Flow

```bash
git checkout develop
echo "// Update index.js" >> src/index.js
git add src/index.js
git commit -m "Test webhook by updating index.js"
git push origin develop
```

➡ JJenkins should automatically trigger:

* Docker build & push
* Terraform infra provision (if not already)
* Ansible deployment

---

### Step 8: Final Merge

```bash
git checkout main
git merge develop
git push origin main
```

---

##  Branching Strategy

| Branch    | Purpose                       |
| --------- | ----------------------------- |
| `main`    | Stable, production-ready code |
| `develop` | Active development            |

---

##  Outcome

* Complete CI/CD pipeline on AWS EC2
* Dockerized Node.js app deployed automatically
* Jenkins automates the flow end-to-end
* GitHub Webhook integration with Jenkins
* Infrastructure as code with Terraform
* Seamless deployment with Ansible

