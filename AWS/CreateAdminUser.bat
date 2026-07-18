#!/usr/bin/env bash

###############################################################################
# Script Name : create-admin-user.sh
#
# Purpose:
#   Create an IAM Administrator user from the AWS Root account (or another
#   administrator account).
#
# What this script does:
#   1. Creates an IAM user.
#   2. Creates an "Administrators" IAM group (if it doesn't already exist).
#   3. Attaches the AWS managed AdministratorAccess policy to the group.
#   4. Adds the IAM user to the Administrators group.
#   5. Creates a console login password.
#   6. Displays the AWS Console login URL.
#
# Prerequisites:
#   - UPDATE THE PASSWORD ***.
#   - Run from AWS CloudShell or a machine configured with AWS CLI.
#   - The executing identity must have IAM administrative permissions.
#
# NOTE:
#   This script is intended for learning and initial AWS account setup.
#   For production environments:
#     - Enable MFA.
#     - Avoid using long-lived IAM users when IAM Identity Center (SSO)
#       is available.
###############################################################################

set -e

############################
# Configuration
############################

# IAM username to create
USERNAME="vijay-admin"

# Initial console password
# Change this before running.
PASSWORD="YourStrongPassword@123"

# IAM administrator group
GROUP_NAME="Administrators"

# AWS Managed Policy ARN
ADMIN_POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"

echo "=========================================================="
echo "Creating AWS Administrator IAM User"
echo "=========================================================="

############################
# Step 1 - Create IAM User
############################

echo ""
echo "Step 1 - Creating IAM user..."

aws iam create-user \
    --user-name "$USERNAME" \
    >/dev/null

echo "✓ User '$USERNAME' created."

############################
# Step 2 - Create IAM Group
############################

echo ""
echo "Step 2 - Creating Administrators group (if needed)..."

aws iam create-group \
    --group-name "$GROUP_NAME" \
    2>/dev/null || true

echo "✓ Group verified."

############################
# Step 3 - Attach Administrator Policy
############################

echo ""
echo "Step 3 - Attaching AdministratorAccess policy..."

aws iam attach-group-policy \
    --group-name "$GROUP_NAME" \
    --policy-arn "$ADMIN_POLICY_ARN"

echo "✓ Administrator policy attached."

############################
# Step 4 - Add User to Group
############################

echo ""
echo "Step 4 - Adding user to administrator group..."

aws iam add-user-to-group \
    --user-name "$USERNAME" \
    --group-name "$GROUP_NAME"

echo "✓ User added to Administrators group."

############################
# Step 5 - Create Console Password
############################

echo ""
echo "Step 5 - Creating console login profile..."

aws iam create-login-profile \
    --user-name "$USERNAME" \
    --password "$PASSWORD" \
    --no-password-reset-required

echo "✓ Console login created."

############################
# Step 6 - Display Login URL
############################

ACCOUNT_ID=$(aws sts get-caller-identity \
    --query Account \
    --output text)

echo ""
echo "=========================================================="
echo "AWS Administrator User Created Successfully"
echo "=========================================================="

echo "AWS Account ID : $ACCOUNT_ID"
echo "Username       : $USERNAME"
echo "Password       : $PASSWORD"

echo ""
echo "AWS Console Login URL"
echo "https://${ACCOUNT_ID}.signin.aws.amazon.com/console"

echo ""
echo "Next Recommended Steps:"
echo "  1. Log in using the new IAM user."
echo "  2. Enable MFA for the IAM user."
echo "  3. Stop using the Root account for daily work."
echo "  4. Secure the Root account with MFA."
