# Transactions

## Overview
This is a UIKit-based iOS application that displays a list of credit card transactions and a detailed view for each transaction.

The app uses a local JSON file as a data source and demonstrates clean architecture using MVVM and programmatic UI.

---

## Features

- Load transactions from a local JSON file (`transaction-list.json`)
- Display transaction list with:
  - Merchant name
  - Formatted amount
- Navigate to transaction details on selection
- Detail screen includes:
  - Credit / Debit indicator (green/red)
  - From account with **last 4 digits only**
  - Amount

---


## How to Run

1. Open the project in the latest version of Xcode
2. Select a simulator
3. Press **Run (⌘R)**
4. The app will launch showing the transactions list

**Notes:**
- No API setup required (uses local JSON)
- Ensure `transaction-list.json` is included in the app bundle

