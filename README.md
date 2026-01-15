# Zendvo - Unlock the Magic of Surprise 🎁

Zendvo is a web-based Progressive Web App (PWA) built with Flutter that enables users to send cash gifts that remain completely hidden until a predetermined unlock date and time.

## 🌟 Core Value Proposition

Transform digital money transfers into memorable experiences by adding mystery, anticipation, and celebration through time-locked gifts.

## 🚀 Key Features

- **Complete Invisibility**: Recipients cannot see the amount, sender identity, or message until the exact unlock moment.
- **Time-Locked Smart Contracts**: Secured using Soroban on the Stellar blockchain.
- **Multi-Channel Sharing**: Share gifts via WhatsApp, Telegram, QR Codes, or Universal Links.
- **Celebratory Unlock**: Immersive unlock animations and confetti for a memorable experience.
- **Easy Withdrawals**: Seamlessly withdraw USDC to Nigerian bank accounts via Paystack/Flutterwave.

## 💻 Technology Stack

- **Frontend**: Flutter (Web/PWA)
- **Blockchain**: Stellar Network (Soroban Smart Contracts)
- **Currency**: USDC Stablecoin
- **Payments**: Stripe (Sender) & Paystack/Flutterwave (Recipient)

## 🏗️ Architecture

The project follows **Clean Architecture** principles:

- `lib/core`: Shared utilities, themes, and network configuration.
- `lib/features`: Modularized features (Auth, Gift Creation, Dashboard, Withdrawal, etc.).

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK
- Stellar SDK configuration

### Getting Started

1. Clone the repository.
2. Run `flutter pub get` to fetch dependencies.
3. Use `flutter run -d chrome` to run the PWA locally.

## 🛡️ Compliance & Security

- **Data Protection**: NDPR compliant.
- **Verification**: Phone-based OTP verification.
- **Trust**: Verified WhatsApp Business API integration.

---

Built with ❤️ by the Zendvo Team.
