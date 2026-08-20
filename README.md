# ☁️ Cloud Resume Challenge

My implementation of the Cloud Resume Challenge using AWS and Terraform.

## 🚀 Live Resume

My resume is hosted on AWS using Amazon S3 and CloudFront.

**CloudFront:**  
https://ddloq9w8rhggb.cloudfront.net

## 🏗️ Architecture

```text
                    ┌──────────────┐
                    │   Internet   │
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  CloudFront  │
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │      S3      │
                    │ Resume HTML  │
                    └──────────────┘


              Visitor Counter
              
                    Browser
                       │
                       ▼
                ┌─────────────┐
                │ API Gateway  │
                └──────┬──────┘
                       │
                       ▼
                ┌─────────────┐
                │   Lambda    │
                │   Python    │
                └──────┬──────┘
                       │
                       ▼
                ┌─────────────┐
                │  DynamoDB   │
                │ Visitor     │
                │ Count       │
                └─────────────┘
