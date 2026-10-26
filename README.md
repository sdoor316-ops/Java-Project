# GrandStay — Hotel Reservation System

> **A Premium Luxury Hotel Management & Booking Desktop Application in Java Swing**  
> Designed for B.Tech IT College Project Demonstrations and Technical Viva Voce.

---

## 1. Project Overview

**GrandStay** is an enterprise-grade desktop hotel reservation and front-desk operations platform built entirely using **Java (Standard Edition)** and **Java Swing**. Tailored with a modern luxury hotel aesthetic—featuring deep navy, warm gold, charcoal, ivory, and crisp white surfaces—it provides an intuitive experience for front-desk receptionists, hotel managers, and guests.

Unlike standard textbook forms, GrandStay incorporates real-time reactivity, anti-aliased custom typography, rounded card panels, custom data tables with status badges, date conflict prevention, automated itemized billing, and local file persistence.

---

## 2. Mandatory Java Concepts Implemented

Every mandatory syllabus concept is implemented in working production code and documented for easy viva explanation:

| # | Java Concept | Component / Class | Implementation Details |
|---|---|---|---|
| **A** | **Hashtable** | [`HotelManagementSystem.java`](src/com/grandstay/service/HotelManagementSystem.java) | `Hashtable<Integer, Room> roomInventory` manages room storage with $O(1)$ lookups. Uses `roomInventory.put()` in `addRoom()`, `roomInventory.get()` in `checkAvailability()`, and enforces room ID uniqueness. |
| **B** | **Queue** | [`ReservationQueue.java`](src/com/grandstay/service/ReservationQueue.java) | `Queue<Reservation> pending = new LinkedList<>()` processes bookings in strict **FIFO (First-In, First-Out)** order. Enqueues with `pending.offer()` and confirms arrivals with `pending.poll()`. |
| **C** | **Stack** | [`GuestHistory.java`](src/com/grandstay/service/GuestHistory.java) | `Stack<String> checkoutLog` records completed checkout events in **LIFO (Last-In, First-Out)** order. Uses `checkoutLog.push()` upon checkout and `checkoutLog.peek()` in `getLastCheckout()` with safe empty-stack handling. |
| **D** | **Enum** | [`RoomType.java`](src/com/grandstay/model/RoomType.java) | `enum RoomType { STANDARD, DELUXE, SUITE, PENTHOUSE }`. Each category encapsulates display names, base pricing ($120, $220, $380, $750), and amenity descriptions, powering dynamic UI dropdowns. |
| **E** | **Calendar** | [`Reservation.java`](src/com/grandstay/model/Reservation.java), [`DateUtils.java`](src/com/grandstay/util/DateUtils.java) | `java.util.Calendar` tracks check-in and checkout dates. Implements `calculateTotalCost(Calendar in, Calendar out)`, validates that checkout is strictly after check-in, and computes stay duration in nights. |
| **F** | **Static Variables** | [`Room.java`](src/com/grandstay/model/Room.java) | `public static int totalRooms` is incremented when rooms are added and decremented when rooms are removed. `public static double basePrice` maintains the global baseline price benchmark. |

---

## 3. Project Architecture

The codebase follows the Model-View-Service-Utility architecture:

```
d:\Users\tejaswini nagothu\Desktop\java\
├── src\
│   └── com\
│       └── grandstay\
│           ├── Main.java                          # Application entry point & Swing Look & Feel
│           ├── SystemTest.java                    # 44-point automated test and verification suite
│           ├── model\
│           │   ├── Room.java                      # Room entity with static totalRooms & basePrice
│           │   ├── RoomType.java                  # Room category Enum (STANDARD, DELUXE, SUITE, PENTHOUSE)
│           │   ├── RoomStatus.java                # Status Enum (AVAILABLE, RESERVED, OCCUPIED)
│           │   ├── Guest.java                     # Guest entity (guestId, name, contactNo, email)
│           │   ├── Reservation.java               # Reservation with java.util.Calendar & calculateTotalCost()
│           │   └── ReservationStatus.java         # Lifecycle Enum (PENDING, CONFIRMED, CHECKED_IN, etc.)
│           ├── service\
│           │   ├── HotelManagementSystem.java     # Hashtable inventory, room availability & core business logic
│           │   ├── ReservationQueue.java          # Queue<Reservation> using LinkedList (offer & poll)
│           │   ├── GuestHistory.java              # Stack<String> checkoutLog (push, peek, LIFO history)
│           │   └── BillingService.java            # Itemized charges (10% tax, 5% service, ASCII receipt)
│           ├── util\
│           │   ├── DateUtils.java                 # Calendar normalization, date arithmetic & interval overlap
│           │   ├── ValidationUtils.java           # Phone regex, numeric bounds, guest and room ID validation
│           │   └── DataStorage.java               # Robust local state persistence (auto-save / auto-load)
│           └── ui\
│               ├── Theme.java                     # Luxury palette (Navy, Gold, Ivory), typography & factory helpers
│               ├── MainFrame.java                 # Main window, navigation sidebar & real-time header clock
│               ├── components\
│               │   ├── ModernButton.java          # Rounded buttons with hover, active & luxury styling
│               │   ├── ModernCardPanel.java       # Clean white card surfaces with subtle borders & gold lines
│               │   ├── StatCard.java              # Dashboard metric card with bold values and category badges
│               │   ├── ModernTable.java           # Styled JTable with dark navy headers & status badge renderers
│               │   ├── DatePickerPanel.java       # User-friendly Calendar date selector with quick +day buttons
│               │   └── ReceiptDialog.java         # Printable invoice modal with copy-to-clipboard & file saving
│               └── panels\
│                   ├── DashboardPanel.java        # Page 1: Live stats, occupancy bar, Stack.peek(), quick actions
│                   ├── RoomManagementPanel.java   # Page 2: Add room, Hashtable table, search, category/status filters
│                   ├── GuestManagementPanel.java  # Page 3: Register guests, phone validation, booking profile lookup
│                   ├── ReservationPanel.java      # Page 4: Book room, live Calendar nights/bill diff, Queue.offer()
│                   ├── QueuePanel.java            # Page 5: FIFO Queue table, head-of-line card, Queue.poll() confirm
│                   ├── CheckInOutPanel.java       # Page 6: Arrival check-in (OCCUPIED) & checkout billing (Stack.push)
│                   ├── HistoryPanel.java          # Page 7: LIFO checkout stack table, Stack.peek() highlight, search
│                   └── BillingPanel.java          # Page 8: Luxury guest invoice view, printable receipt, analytics
├── data\
│   └── grandstay_store.dat                        # Saved local application state (auto-generated)
├── bin\                                           # Compiled Java .class bytecode
├── compile.bat                                    # One-click Windows compilation script
├── run.bat                                        # One-click Windows launch script
├── test.bat                                       # One-click Windows verification test script
└── README.md                                      # Documentation & Viva Guide
```

---

## 4. Key Application Pages

1. **Dashboard Overview**: Displays live counts for Total Rooms (`static totalRooms`), Available Rooms (`Hashtable`), Reserved Rooms, Occupied Rooms, and Pending Requests (`Queue`). Features an occupancy utilization bar, recent activity stream, and the latest guest checkout preview using `Stack.peek()`.
2. **Room Inventory (Hashtable)**: Add new rooms with unique room numbers, category selection from `RoomType` enum, and custom pricing. Demonstrates `Hashtable.put()` and `Hashtable.get()`. Provides room deletion which safely decrements `Room.totalRooms`.
3. **Guest Directory**: Register guests with contact validation. View individual guest stay history and total reservation count.
4. **Make a Reservation**: Interactive booking form. Calculates the duration in nights and estimated bill in real time as the user selects dates or rooms. Prevents double-booking via date-conflict checking. Adds the request to the pending queue via `Queue.offer()`.
5. **Reservation Queue (FIFO Queue)**: Visualizes requests in strict FIFO order. Shows the request at the head of the queue. Clicking **"Confirm Next Reservation"** calls `Queue.poll()`, marks the reservation as `CONFIRMED`, and locks the room as `RESERVED` in the Hashtable.
6. **Front Desk Check-In & Checkout**:
   - *Check-In Tab*: View confirmed arrivals and check in guests, updating room status to `OCCUPIED`.
   - *Checkout Tab*: View current in-house guests, compute final bills (with 10% Luxury Tax and 5% Service Charge), mark rooms back to `AVAILABLE`, and record the stay into the checkout log via `Stack.push()`.
7. **Checkout History (LIFO Stack)**: Shows all completed checkouts in reverse chronological order. Highlights the top of the stack using `Stack.peek()` with safe empty-stack handling.
8. **Billing & Reports**: View official hotel invoices with complete charge breakdowns. Open printable receipts in the `ReceiptDialog` to copy or save to text files. Review gross hotel revenue and average stay duration.

---

## 5. How to Compile and Run

### Prerequisites
- Java Development Kit (JDK 8 or higher; tested and verified on **Java 27**).

### Option A: Using Windows Batch Scripts
Double-click or run from PowerShell / Command Prompt:
```cmd
compile.bat    :: Compiles all source files into bin/
run.bat        :: Launches GrandStay GUI
test.bat       :: Runs the 44-point automated test suite
```

### Option B: Manual Command Line
```powershell
# 1. Compile source code
javac -encoding UTF-8 -d bin -sourcepath src src\com\grandstay\Main.java src\com\grandstay\model\*.java src\com\grandstay\service\*.java src\com\grandstay\util\*.java src\com\grandstay\ui\*.java src\com\grandstay\ui\components\*.java src\com\grandstay\ui\panels\*.java src\com\grandstay\SystemTest.java

# 2. Run GrandStay GUI
java -Dfile.encoding=UTF-8 -cp bin com.grandstay.Main

# 3. Run Automated System Diagnostic Test
java -Dfile.encoding=UTF-8 -cp bin com.grandstay.SystemTest
```

---

## 6. Sample Demonstration Dataset

On first launch, GrandStay automatically initializes a realistic demonstration dataset:
- **12 Rooms**:
  - Standard: Rooms 101, 102, 103 ($120.00 - $125.00/night)
  - Deluxe: Rooms 201, 202, 203 ($220.00 - $235.00/night)
  - Suite: Rooms 301, 302, 303 ($380.00 - $395.00/night)
  - Penthouse: Rooms 401, 402, 403 ($750.00 - $850.00/night)
- **5 Registered Guests**: Fictional profiles with valid contact numbers and email addresses.
- **Active Operations**: Pre-populated with checked-in guests, confirmed bookings, pending FIFO requests, and past checkout records.

---

## 7. Five Sample Viva Questions & Simple Answers

### Q1: Why did you choose `Hashtable` for Room Inventory instead of an `ArrayList` or `HashMap`?
> **Answer:** `Hashtable<Integer, Room>` maps a unique Room Number (`Integer`) directly to its `Room` object. This provides $O(1)$ constant-time lookup and insertion, allowing instant room availability checks via `Hashtable.get()`. Additionally, `Hashtable` is synchronized and thread-safe, and disallows null keys and values, which prevents accidental corruption of hotel room records.

### Q2: How does the Reservation Queue guarantee fairness in booking requests?
> **Answer:** The reservation queue is implemented using `java.util.Queue<Reservation>` backed by a `java.util.LinkedList`. It adheres to the **FIFO (First-In, First-Out)** principle: incoming reservation requests are enqueued at the back using `offer()`, and the front desk confirms requests from the front using `poll()`. This guarantees that guests are processed strictly in the order their booking requests were submitted.

### Q3: Where is the `Stack` data structure used, and what is the difference between `peek()` and `pop()`?
> **Answer:** `Stack<String>` is used in `GuestHistory.java` to track completed guest checkouts. Each time a guest completes checkout, the record is pushed to the top via `checkoutLog.push()`. We use `peek()` in `getLastCheckout()` to inspect the most recent checkout entry at the top of the stack without removing it. In contrast, `pop()` would retrieve and permanently remove the top element.

### Q4: How is `java.util.Calendar` utilized to calculate stay duration and total cost?
> **Answer:** In `Reservation.java`, `Calendar` objects store normalized check-in and checkout dates. By calculating the difference between `checkOut.getTimeInMillis()` and `checkIn.getTimeInMillis()` divided by $(24 \times 60 \times 60 \times 1000)$, we obtain the exact number of nights. We validate that `checkOut.after(checkIn)` is true, and calculate `totalCost = nights * room.getPricePerNight()`.

### Q5: What is the purpose of the `static` variable `totalRooms` in the `Room` class?
> **Answer:** A `static` variable belongs to the `Room` class itself rather than to any individual room instance. `Room.totalRooms` serves as a global counter shared across the entire system. It increments whenever a new room is added to inventory (`addRoom`) and decrements if a room is removed (`removeRoom`), ensuring that the hotel capacity counter is always synchronized with the inventory.
