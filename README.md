# TrackAm Backend Brief

The TrackAm Backend powers the expense tracking system by providing authentication, data management, and communication services. It is built using serverless architecture on AWS, with MongoDB as the database.

## Process Overview

### User Registration & Authentication

Handled via Amazon Cognito.

Supports sign-up, login, password reset, and secure session management.

### Business Logic Execution

Implemented using AWS Lambda functions.

Functions are triggered by API Gateway to process requests from the frontend.

### Data Storage

MongoDB stores user and transaction data.

Provides a scalable NoSQL database optimized for expense tracking.

### File Management

Amazon S3 securely stores static assets and user-related files.

Integrated with CloudFront for fast and reliable content delivery.

### Email Notifications

Amazon SES (Simple Email Service) is used to send emails such as account confirmation, password reset, and alerts.

## Resources & Their Essence

### Amazon S3

Stores static assets and serves as part of the application’s storage layer.

Ensures durability, availability, and low-cost file hosting.

### MongoDB

Primary database for user profiles, transactions, and expense data.

Chosen for flexibility and ability to handle unstructured or semi-structured data.

### Amazon Cognito

Provides user identity and authentication services.

Handles secure sign-up, sign-in, and token-based authentication.

### AWS Lambda

Executes serverless backend logic.

Manages operations such as authentication flows, expense tracking, and API responses without provisioning servers.

### Amazon SES

Sends transactional and notification emails.

Provides reliable, cost-effective communication with users.

## Infrastructure Management

Terraform is used to define and provision all resources as code.

Ensures reproducibility, consistency, and version control for infrastructure.

## CI/CD

GitHub Actions automates:

Terraform validation and deployment.

Synchronizing application files to S3.

Triggering backend updates seamlessly.

## Maintainers

TrackAm Team