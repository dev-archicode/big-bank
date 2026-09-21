imports:
  - internet-banking
  - landscape

elements:
  customer-mobile-device:
    type: deployment-node
    name: Customer's mobile device
    description: "The phone or tablet a customer banks from."
    properties:
      technology: Apple iOS or Android
    relations:
      - type: hosts
        target: internet-banking.mobile-app

  customer-computer:
    type: deployment-node
    name: Customer's computer
    description: "The desktop or laptop a customer banks from."
    properties:
      technology: Microsoft Windows or Apple macOS
    relations:
      - type: contains
        target: web-browser

  web-browser:
    type: deployment-node
    name: Web Browser
    description: "The browser the single-page application runs in."
    properties:
      technology: "Chrome, Firefox, Safari, or Edge"
    relations:
      - type: hosts
        target: internet-banking.single-page-application

  data-center:
    type: deployment-node
    name: Big Bank plc
    description: "The bank's own data center."
    properties:
      technology: Big Bank plc data center
    relations:
      - type: contains
        target: load-balancer
      - type: contains
        target: web-servers
      - type: contains
        target: api-servers
      - type: contains
        target: primary-database-server
      - type: contains
        target: secondary-database-server
      - type: contains
        target: mainframe

  load-balancer:
    type: infrastructure-node
    name: Load Balancer
    description: "Spreads incoming requests across the web and API servers."
    properties:
      technology: F5 BIG-IP
    relations:
      - type: uses
        target: internet-banking.web-application
        description: "Forwards requests to"
        properties:
          technology: HTTPS
      - type: uses
        target: internet-banking.api-application
        description: "Forwards requests to"
        properties:
          technology: HTTPS

  web-servers:
    type: deployment-node
    name: bigbank-web***
    description: "The pool of web servers."
    properties:
      technology: Ubuntu 16.04 LTS
      instances: 4
    relations:
      - type: contains
        target: web-server-tomcat

  web-server-tomcat:
    type: deployment-node
    name: Apache Tomcat
    description: "The servlet container that runs the web application."
    properties:
      technology: Apache Tomcat 8.x
    relations:
      - type: hosts
        target: internet-banking.web-application

  api-servers:
    type: deployment-node
    name: bigbank-api***
    description: "The pool of API servers."
    properties:
      technology: Ubuntu 16.04 LTS
      instances: 8
    relations:
      - type: contains
        target: api-server-tomcat

  api-server-tomcat:
    type: deployment-node
    name: Apache Tomcat
    description: "The servlet container that runs the API application."
    properties:
      technology: Apache Tomcat 8.x
    relations:
      - type: hosts
        target: internet-banking.api-application

  primary-database-server:
    type: deployment-node
    name: bigbank-db01
    description: "The primary database server."
    properties:
      technology: Ubuntu 16.04 LTS
    relations:
      - type: contains
        target: primary-oracle
      - type: uses
        target: secondary-database-server
        description: "Replicates data to"

  primary-oracle:
    type: deployment-node
    name: Oracle - Primary
    description: "The database engine serving live traffic."
    properties:
      technology: Oracle 12c
    relations:
      - type: hosts
        target: internet-banking.database

  secondary-database-server:
    type: deployment-node
    name: bigbank-db02
    description: "The standby database server."
    properties:
      technology: Ubuntu 16.04 LTS
    relations:
      - type: contains
        target: secondary-oracle

  secondary-oracle:
    type: deployment-node
    name: Oracle - Secondary
    description: "The standby database engine, kept in step by replication."
    properties:
      technology: Oracle 12c
    relations:
      - type: hosts
        target: internet-banking.database

  mainframe:
    type: deployment-node
    name: bigbank-prod001
    description: "The mainframe the core banking system runs on."
    relations:
      - type: hosts
        target: landscape.mainframe-banking-system
