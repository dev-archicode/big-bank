imports:
  - internet-banking

elements:
  personal-banking-customer:
    type: person
    name: Personal Banking Customer
    description: "A customer of the bank, with personal bank accounts."
    relations:
      - type: uses
        target: internet-banking.internet-banking-system
        description: "Views account balances, and makes payments using"
      - type: uses
        target: internet-banking.web-application
        description: "Visits bigbank.com/ib using"
        properties:
          technology: HTTPS
      - type: uses
        target: internet-banking.single-page-application
        description: "Views account balances, and makes payments using"
      - type: uses
        target: internet-banking.mobile-app
        description: "Views account balances, and makes payments using"
      - type: uses
        target: customer-service-staff
        description: "Asks questions to"
        properties:
          technology: Telephone

  customer-service-staff:
    type: person
    name: Customer Service Staff
    description: "Customer service staff within the bank."
    relations:
      - type: uses
        target: mainframe-banking-system
        description: "Looks up customers' accounts and transactions in"

  mainframe-banking-system:
    type: software-system
    name: Mainframe Banking System
    description: "Stores all of the core banking information about customers, accounts, transactions, etc."

  email-system:
    type: software-system
    name: E-mail System
    description: "The internal Microsoft Exchange e-mail system."
    relations:
      - type: uses
        target: personal-banking-customer
        description: "Sends e-mails to"
