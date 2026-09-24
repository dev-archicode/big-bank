imports:
  - landscape

elements:
  sign-in-controller:
    type: component
    name: Sign In Controller
    description: "Allows users to sign in to the Internet Banking System."
    properties:
      technology: Spring MVC Rest Controller
    relations:
      - type: uses
        target: security-component
        description: "Checks credentials using"

  accounts-summary-controller:
    type: component
    name: Accounts Summary Controller
    description: "Provides customers with a summary of their bank accounts."
    properties:
      technology: Spring MVC Rest Controller
    relations:
      - type: uses
        target: mainframe-banking-system-facade
        description: "Gets account summaries using"

  reset-password-controller:
    type: component
    name: Reset Password Controller
    description: "Allows users to reset their passwords with a single use URL."
    properties:
      technology: Spring MVC Rest Controller
    relations:
      - type: uses
        target: security-component
        description: "Changes the password using"
      - type: uses
        target: email-component
        description: "Sends the reset link using"

  security-component:
    type: component
    name: Security Component
    description: "Provides functionality related to signing in, changing passwords, etc."
    properties:
      technology: Spring Bean
    relations:
      - type: uses
        target: database
        description: "Reads from and writes to"
        properties:
          technology: SQL/TCP

  mainframe-banking-system-facade:
    type: component
    name: Mainframe Banking System Facade
    description: "A facade onto the mainframe banking system."
    properties:
      technology: Spring Bean
    relations:
      - type: uses
        target: landscape.mainframe-banking-system
        description: "Makes API calls to"
        properties:
          technology: XML/HTTPS

  email-component:
    type: component
    name: E-mail Component
    description: "Sends e-mails to users."
    properties:
      technology: Spring Bean
    relations:
      - type: uses
        target: landscape.email-system
        description: "Sends e-mail using"
        properties:
          technology: SMTP
