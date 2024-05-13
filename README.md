# README

Tea Subscription API
Introduction
Welcome to the Tea Subscription API! This API allows users to manage tea subscriptions for customers. It provides endpoints for creating, updating, and canceling subscriptions, as well as retrieving information about subscriptions.

Base URL
The base URL for this API is https://your-api-base-url.com.

Authentication
Authentication is not required for accessing the endpoints of this API.

Endpoints
1. Retrieve All Subscriptions
URL: /api/v0/customers/:customer_id/subscriptions

Method: GET

Description: Retrieves all active and cancelled subscriptions for a given customer.

2. Create New Subscription
URL: /api/v0/customers/:customer_id/subscriptions

Method: POST

Description: Creates a new subscription for a customer.

Request Body:

```
{
  "customer_id": "ID of the customer",
  "tea_id": "ID of the tea",
  "frequency": "Frequency of the subscription",
  "status": "Status of the subscription"
}
```

3. Cancel Subscription
URL: /api/v0/customers/:customer_id/subscriptions/:id

Method: PATCH

Description: Cancels a subscription for a customer.

Request Body:

```
{
  "customer_id": "ID of the customer",
  "tea_id": "ID of the tea"
}
```

Testing
This API comes with automated tests to ensure its functionality. You can run these tests using the following command:
```
$ rspec spec
```
Tests can be run invidually with the following syntax:

```
$ rspec spec/path_to_test_folder_or_test_filename
```

Dependencies
This API relies on the following dependencies:

Ruby on Rails (version 7.1.3.2)   RSpec for testing


**Getting Started**

To get started with this API, follow these steps:


*Clone the repository:*  git clone https://github.com/your-repo.git


*Install dependencies:*  bundle install

*Run the server:*  rails server


Contributors
Matt Darlington
matthewsdarlington@gmail.com


