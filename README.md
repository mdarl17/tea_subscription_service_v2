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
  "customer_id": 1,
  "tea_id": 1,
  "frequency": 0,
  "status": 0
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
