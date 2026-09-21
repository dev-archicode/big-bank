imports:
  - landscape

elements:
  internet-banking-system:
    type: software-system
    name: Internet Banking System
    description: "Allows customers to view information about their bank accounts, and make payments."
    relations:
      - type: contains
        target: web-application
      - type: contains
        target: single-page-application
      - type: contains
        target: mobile-app
      - type: contains
        target: api-application
      - type: contains
        target: database
      - type: uses
        target: landscape.mainframe-banking-system
        description: "Gets account information from, and makes payments using"
      - type: uses
        target: landscape.email-system
        description: "Sends e-mail using"

  web-application:
    type: container
    name: Web Application
    description: "Delivers the static content and the Internet banking single page application."
    properties:
      technology: Java and Spring MVC
    relations:
      - type: uses
        target: single-page-application
        description: "Delivers to the customer's web browser"
        properties:
          technology: HTTPS

  single-page-application:
    type: container
    name: Single-Page Application
    description: "Provides all of the Internet banking functionality to customers via their web browser."
    properties:
      technology: JavaScript and Angular
    relations:
      - type: uses
        target: api-application
        description: "Makes API calls to"
        properties:
          technology: JSON/HTTPS
      - type: uses
        target: sign-in-controller
        description: "Makes API calls to"
        properties:
          technology: JSON/HTTPS
      - type: uses
        target: accounts-summary-controller
        description: "Makes API calls to"
        properties:
          technology: JSON/HTTPS
      - type: uses
        target: reset-password-controller
        description: "Makes API calls to"
        properties:
          technology: JSON/HTTPS

  mobile-app:
    type: container
    name: Mobile App
    description: "Provides a limited subset of the Internet banking functionality to customers via their mobile device."
    properties:
      technology: Xamarin
    relations:
      - type: uses
        target: api-application
        description: "Makes API calls to"
        properties:
          technology: JSON/HTTPS
      - type: uses
        target: sign-in-controller
        description: "Makes API calls to"
        properties:
          technology: JSON/HTTPS
      - type: uses
        target: accounts-summary-controller
        description: "Makes API calls to"
        properties:
          technology: JSON/HTTPS

  api-application:
    type: container
    name: API Application
    description: "Provides Internet banking functionality via a JSON/HTTPS API."
    properties:
      technology: Java and Spring MVC
    relations:
      - type: contains
        target: sign-in-controller
      - type: contains
        target: accounts-summary-controller
      - type: contains
        target: reset-password-controller
      - type: contains
        target: security-component
      - type: contains
        target: mainframe-banking-system-facade
      - type: contains
        target: email-component
      - type: uses
        target: database
        description: "Reads from and writes to"
        properties:
          technology: SQL/TCP
      - type: uses
        target: landscape.mainframe-banking-system
        description: "Makes API calls to"
        properties:
          technology: XML/HTTPS
      - type: uses
        target: landscape.email-system
        description: "Sends e-mail using"
        properties:
          technology: SMTP

  database:
    type: container
    name: Database
    description: "Stores user registration information, hashed authentication credentials, access logs, etc."
    properties:
      technology: Oracle Database Schema
