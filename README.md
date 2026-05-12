Workflow YAML file : .github/workflows/

Screenshot of successful pipeline execution(Drive): https://drive.google.com/drive/folders/1uI6A5-CqEGepnPsia8oZBbsmBFuWDDx6?usp=sharing

CI/CD stands for:

 
 CI = Continuous Integration
 
 
 CD = Continuous Delivery / Continuous Deployment
 
 
 It is a modern software development practice used in tools like GitHub Actions, Jenkins, GitLab CI, etc.

Self-hosted Runner: 
 A self-hosted runner in GitHub Actions is:

  A machine (My own server, PC, or VM) that configure to run GitHub Actions jobs instead of using GitHub’s cloud machines.

Workflow execution process:

 The GitHub Actions workflow execution process in GitHub follows a clear pipeline of stages from trigger to completion.
 Common triggers: push
 Example: Developer pushes code → workflow starts

 Workflow is Loaded

GitHub:
  
  reads .github/workflows/*.yml
  checks matching trigger rules


   9. Workflow Completion

  When all jobs finish:

   workflow status becomes:
   ✅ success
   ❌ failed
   ⏭ skipped
Workflow summary: 
   Trigger → Load Workflow → Create Jobs → Assign Runner → Execute Steps → Logs → Job Result → Workflow Result



   YAML File:


   
name: Django CI Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: self-hosted

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Check Python
        run: python3 --version

      - name: Create venv
        run: python3 -m venv venv

      - name: Install dependencies
        run: |
          ./venv/bin/pip install -r requirements.txt

      - name: Run migrations
        env:
          DB_NAME: testdb
          DB_USER: postgres
          DB_PASSWORD: 123456
          DB_HOST: 127.0.0.1
        run: ./venv/bin/python manage.py migrate

      - name: Run tests
        env:
          DB_NAME: testdb
          DB_USER: postgres
          DB_PASSWORD: 123456
          DB_HOST: 127.0.0.1
        run: ./venv/bin/python manage.py test



