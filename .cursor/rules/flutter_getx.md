# Flutter UI + GetX Complete Best Practices Guide (Cursor-Optimized)

> **Purpose**: This document is designed to be dropped directly into Cursor (or any AI coding IDE) as a **single source of truth** for building Flutter UI using **GetX**.
> Cursor should strictly follow these rules when generating, refactoring, or reviewing Flutter code.

---

## 0. How Cursor Should Use This File

- Treat this as **authoritative rules**, not suggestions
- Follow folder structure exactly
- Never mix UI and business logic
- Default to GetX patterns defined here
- Prefer refactoring to match this guide

---

## 1. Core Principles (Non‑Negotiable)

- UI must be **StatelessWidget-first**
- Business logic **never lives in widgets**
- Controllers manage:

  - state
  - API calls
  - validation
  - navigation decisions

- Widgets only:

  - render UI
  - react to state

- Prefer **composition over inheritance**
- Prefer **small widgets over large widgets**
- Prefer **explicit code over magic**

---

## 2. Folder Structure (Feature‑First, Mandatory)

```
lib/
│
├── app/
│   ├── routes/
│   │   ├── app_routes.dart
│   │   └── app_pages.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   │
│   └── bindings/
│       └── initial_binding.dart
│
├── features/
│   ├── auth/
│   │   ├── controller/
│   │   │   └── auth_controller.dart
│   │   ├── view/
│   │   │   └── login_page.dart
│   │   ├── widget/
│   │   │   └── login_form.dart
│   │   └── binding/
│   │       └── auth_binding.dart
│   │
│   ├── home/
│   │   ├── controller/
│   │   ├── view/
│   │   ├── widget/
│   │   └── binding/
│
├── core/
│   ├── services/
│   │   ├── api_service.dart
│   │   └── storage_service.dart
│   │
│   ├── utils/
│   │   ├── validators.dart
│   │   └── helpers.dart
│   │
│   └── constants/
│       └── app_constants.dart
│
└── main.dart
```

---

## 3. GetX Architecture Rules

### 3.1 Controllers

- One controller per screen or feature
- Controllers:

  - hold `Rx` state
  - perform async work
  - validate input
  - decide navigation

- Controllers **must not import Flutter UI widgets**

```dart
class LoginController extends GetxController {
  final isLoading = false.obs;
  final email = ''.obs;
  final password = ''.obs;

  Future<void> login() async {
    isLoading.value = true;
    // API call
    isLoading.value = false;
  }
}
```

---

### 3.2 Bindings (Mandatory)

- Every screen **must have a binding**
- Controllers are created **only in bindings**
- ❌ Never use `Get.put()` inside widgets

```dart
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
```

---

### 3.3 Views

- Views are **StatelessWidget only**
- Views:

  - call controller methods
  - observe state via `Obx`

- Views must never contain business logic

```dart
class LoginPage extends StatelessWidget {
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator()
            : const LoginForm()),
      ),
    );
  }
}
```

---

## 4. Widget Design Rules

### 4.1 Widget Size & Responsibility

- One widget = one responsibility
- A widget file should ideally be **< 200 lines**
- Extract widgets aggressively

❌ Bad:

```
LoginPage (500 lines)
```

✅ Good:

```
LoginPage
 ├── LoginForm
 ├── EmailField
 ├── PasswordField
 └── LoginButton
```

---

### 4.2 Use `const` Aggressively

```dart
const SizedBox(height: 16);
```

Benefits:

- Faster rebuilds
- Less memory usage
- Cleaner widget tree

---

## 5. State Management Rules

### 5.1 Rx Usage

- Use `.obs` **only for UI‑reactive state**
- Do NOT make everything reactive

```dart
final count = 0.obs;  // UI state
int pageSize = 20;   // normal variable
```

---

### 5.2 Obx Rules

- Wrap **only the widget that changes**
- ❌ Never wrap an entire screen

❌ Bad:

```dart
Obx(() => Scaffold(...))
```

✅ Good:

```dart
Obx(() => Text(controller.count.value.toString()))
```

---

## 6. Navigation Rules

- Use **named routes only**
- Centralize all routes

```dart
Get.toNamed(Routes.login);
```

```dart
class Routes {
  static const login = '/login';
}
```

---

## 7. Theming & Design System

- No hardcoded colors
- No hardcoded font sizes
- Use centralized theme files

```dart
Text(
  'Login',
  style: AppTextStyles.heading,
)
```

---

## 8. Performance Rules

- Use `ListView.builder` / `GridView.builder`
- Avoid rebuilding large widgets
- Prefer `SizedBox` over `Container`
- Split heavy widgets
- Profile with Flutter DevTools

---

## 9. Screen State Handling (Required)

Every screen must handle:

- Loading
- Error
- Empty

```dart
if (isLoading) return const Loader();
if (hasError) return const ErrorView();
if (data.isEmpty) return const EmptyView();
```

---

## 10. Testing (Recommended)

- Unit test controllers
- Widget test views
- Mock services
- Do NOT test GetX internals

---

## 11. Golden Rules (TL;DR)

- Controllers own logic
- Views are dumb
- Widgets are small
- Bindings are mandatory
- Obx only where needed
- Theme everything
- Feature‑first folders

---

## Final Note for Cursor

> When generating Flutter code:
>
> - Follow this structure
> - Use GetX patterns defined here
> - Refactor existing code to match this guide
> - Reject designs that violate these rules

---

**End of Guide**
