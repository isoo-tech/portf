#!/bin/bash

# Login to Azure (uncomment if not already logged in)
# az login

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Plan the deployment
echo "Planning deployment..."
terraform plan -out=tfplan

# Apply the configuration
echo "Deploying infrastructure..."
terraform apply tfplan

# Get the deployment URL
echo "Getting deployment URL..."
DEPLOYMENT_URL=$(terraform output -raw static_web_app_url)
echo "Your portfolio will be accessible at: https://$DEPLOYMENT_URL"

# Get the API key for GitHub integration
API_KEY=$(terraform output -raw static_web_app_api_key)
echo "Your API key for GitHub Actions integration: $API_KEY"
echo "Note: Keep this key secure and use it in your GitHub repository secrets"

# Instructions for deployment
echo ""
echo "==== NEXT STEPS ===="
echo "1. Copy your portfolio HTML, CSS, and JavaScript files to a folder named 'src'"
echo "2. Deploy your static content using the az command:"
echo "   az staticwebapp appsettings set --name ismael-portfolio --resource-group portfolio-resources --setting-names 'SWA_CLI_DEPLOYMENT_TOKEN=$API_KEY'"
echo "3. Install SWA CLI: npm install -g @azure/static-web-apps-cli"
echo "4. Deploy your content: swa deploy ./src --env production --deployment-token $API_KEY"
echo ""
echo "Alternatively, connect to GitHub and let Azure Static Web Apps deploy automatically from your repository" 