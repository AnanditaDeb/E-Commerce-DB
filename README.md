# E-commerce OLTP Database

A comprehensive OLTP (Online Transaction Processing) database system developed for an e-commerce platform to support critical business functions such as order processing, customer relationship management, inventory control, promotions, and returns. This project ensures efficient data management and optimized transaction processing, facilitating seamless operations for e-commerce business needs.

## Project Overview

This project was designed to handle various components of an e-commerce environment, focusing on:
- **Order Processing**: Streamlined order creation, updating, and tracking.
- **Customer Relationship Management (CRM)**: Efficient storage and management of customer information, enhancing user experience.
- **Inventory Control**: Real-time inventory updates and management, ensuring accurate product availability.
- **Promotions**: Management of promotional campaigns, discounts, and offers to attract and retain customers.
- **Returns & Refunds**: Structured process for handling product returns and refunds, ensuring smooth customer service.

## Key Highlights
- **High Efficiency**: Optimized data structures and processes for fast and reliable transactions.
- **Scalable Design**: Supports large-scale operations with a modular database architecture.
- **Enhanced Data Integrity**: Enforced through primary keys, foreign keys, and data constraints to maintain consistency.

## Tech Stack

- **Database**: Oracle Database
- **Programming Language**: PL/SQL
- **Modeling Tool**: ER Studio

## Database Schema

The database schema is organized to accommodate key e-commerce modules and includes the following major tables:
- **Customers**: Stores customer details and contact information.
- **Orders**: Tracks customer orders, statuses, and payment information.
- **Products**: Maintains product details, prices, and availability.
- **Inventory**: Monitors stock levels and manages inventory status.
- **Promotions**: Stores information on active promotions, discounts, and offers.
- **Returns**: Manages return requests, statuses, and refund details.

## Getting Started

To set up the database and run this project, follow these steps:

### Prerequisites
- Oracle Database installed and configured.
- Oracle SQL Developer or similar IDE for PL/SQL scripting.
- ER Studio for viewing/editing the ER diagrams.

### Setup Instructions
1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/E-commerce_OLTP.git
   cd E-commerce_OLTP
