# 🏟️ SportApp – iOS App (Swift + Alamofire + CoreData)

SportApp is a modern iOS application built with Swift, following MVP architecture, integrating CoreData, Alamofire, Reachability, and UIKit to provide sports-related data fetched from [AllSportsAPI](https://allsportsapi.com/).

---

## 🧠 Features

### 🏠 Home Screen (Tab 1) – Sports List

- Collection view of all sports fetched from the API.
- Two sports per row with spacing.
- Each sport shows its name and thumbnail.
- Tapping a sport navigates to the Leagues screen.

👤 **Done by:** Zeyad Maamoun

---

### ⭐ Favorites Screen (Tab 2)

- Uses CoreData to store and display favorite leagues.
- UI mimics Leagues View.
- Clicking on a league with no internet shows an alert.
- Clicking with internet navigates to League Details.

👤 **Done by:** Zeyad Maamoun

---

### 🏆 Leagues Screen

- Table view showing leagues for a selected sport.
- Custom cells with circular badge and league name.
- Clicking a league navigates to League Details.

👤 **Done by:** Zeyad Maamoun

---

### 📅 League Details Screen

Split into 3 parts:

1. **Upcoming Events** (horizontal collection view)
   - Shows event name, date, time, and team logos.

2. **Latest Results** (vertical collection view)
   - Shows team names, scores, date/time, and logos.

3. **Teams List** (horizontal collection view)
   - Circular team images. Tapping opens team details.

Includes a favorite toggle icon (save/delete to CoreData).

👤 **Done by:** Nadia Ahmed

---

### 🧑‍🤝‍🧑 Team Details Screen

- Elegant view of the selected team's basic info.
- Layout is fully custom and responsive.

👤 **Done by:** Nadia Ahmed

---

## 🧱 Architecture

- Pattern: **MVP** (Model - View - Presenter)
- Networking: **Alamofire**
- Offline storage: **CoreData**
- Network Monitoring: **Reachability**

---

## 🧪 Unit Testing

- Fully tested presenters and data sources.
- Mocking used for networking and database layers.

👤 **Test cases by:** Nadia & Zeyad

---

## 🌐 API

Data is fetched from:

👉 [https://allsportsapi.com](https://allsportsapi.com)

---

## 👥 Team Members

| Feature | Contributor |
|--------|-------------|
| League Details | Nadia Ahmed |
| Team Details | Nadia Ahmed |
| Sports List | Zeyad Maamoun |
| Favorites | Zeyad Maamoun |
| Leagues | Zeyad Maamoun|
| Testing | all team members |

---

Feel free to contact us if you have any questions.  
Thanks for reviewing our project!
