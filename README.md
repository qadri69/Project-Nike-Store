# Nike Store Web Application

## Overview
This project is a web application developed for the course ISB42403 (WEB APPLICATION). It's an e-commerce platform for Nike products that includes user authentication, shopping functionality, and administrative features.

## Technologies Used
- ASP.NET Web Forms
- C#
- SQL Server Database
- HTML/CSS
- JavaScript

## Features
- **User Authentication**: Secure login and registration system using PBKDF2 password hashing
- **Product Browsing**: View products by category with images and descriptions
- **Shopping Cart**: Add products to cart with size and quantity options
- **Order Processing**: Calculate totals with tax and rounding
- **Admin Panel**: Manage users with role-based permissions and account status control

## Project Structure
- **User Interface**
  - [User.Master](User.Master): Master page for consistent UI across all pages
  - [Default.aspx](Default.aspx): Home page displaying product catalog
  - [Shop.aspx](Shop.aspx): Shopping interface with product selection and cart
  - [login.aspx](login.aspx): User authentication page
  - [registration.aspx](registration.aspx): New user registration
  - [Admin.aspx](Admin.aspx): Administrative control panel

- **Backend Logic**
  - [PBKDF2Hash.cs](PBKDF2Hash.cs): Secure password hashing implementation
  - Various code-behind files (.aspx.cs) handling business logic

- **Database**
  - SQL Server database with tables for Users, Products, Categories, and Orders
  - Stored procedures for order processing

## Setup Instructions
1. Clone the repository
2. Open [Project.sln](Project.sln) in Visual Studio
3. Make sure SQL Server is installed and running
4. The database connection string is configured in [Web.config](Web.config)
5. Build and run the application

## Database Schema
- **Users**: User accounts with roles and permissions
- **Products**: Nike products with details and pricing
- **Categories**: Product categories
- **Orders**: Customer orders with line items

## Security
- Passwords are securely hashed using PBKDF2 algorithm
- Role-based access control for admin functions

## CSS Styles
- [Styles/style.css](Styles/style.css): Main stylesheet
- [Styles/registration.css](Styles/registration.css): Styles for user forms
- [Styles/StyleSheet1.css](Styles/StyleSheet1.css): Additional layout styles

## Course Information
- Course: ISB42403 (WEB APPLICATION)
-
